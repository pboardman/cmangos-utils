#!/bin/bash

echo "Starting server"

echo "Waiting on mysql"
while ! mysqladmin ping -hdb --silent; do
  sleep 1
done

# Executing first run
if [ ! -f /home/mangos/run/etc/done_first_run ]; then
  echo "Running first run scripts"

  # Creating empty databases
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb < /home/mangos/mangos/sql/create/db_create_mysql_custom.sql

  # Initializing Mangos database
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb mangos < /home/mangos/mangos/sql/base/mangos.sql

  # Initializing characters database
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb characters < /home/mangos/mangos/sql/base/characters.sql

  # Initializing realmd database
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb realmd < /home/mangos/mangos/sql/base/realmd.sql

  # Removing ONLY_FULL_GROUP_BY from sql_mode (required for UDB)
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb -e "SET GLOBAL sql_mode=''"

  # Installing unifieddb
  cd /home/mangos/unifieddb
  chmod +x InstallFullDB.sh
  ./InstallFullDB.sh
  sed -i -e 's/CORE_PATH=""/CORE_PATH="\/home\/mangos\/mangos"/g' InstallFullDB.config
  sed -i -e 's/DBHOST="localhost"/DBHOST="db"/g' InstallFullDB.config
  cat InstallFullDB.config
  ./InstallFullDB.sh

  echo "UDB done"

  # Filling ScriptDev2 database
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb mangos < /home/mangos/mangos/sql/scriptdev2/scriptdev2.sql

  # Filling ACID to world-database
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb mangos < /home/mangos/acid/acid_wotlk.sql

  # Making server public
  pub_ip=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | cut -d'"' -f2)
  sed -i -e "s/IP/$pub_ip/g" /home/mangos/mangos/sql/base/set_realmlist_public.sql
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb realmd < /home/mangos/mangos/sql/base/set_realmlist_public.sql

  # Creating default gm account (Username: gm PW: password1234)
  mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hdb realmd < /home/mangos/mangos/sql/create_gm_account.sql

  # Creating conf files
  mv /home/mangos/mangos/src/mangosd/mangosd.conf.dist.in /home/mangos/run/etc/mangosd.conf
  sed -i -e 's/127.0.0.1;3306/db;3306/g' /home/mangos/run/etc/mangosd.conf
  sed -i -e 's/DataDir = "."/DataDir = "\/home\/mangos\/run\/"/g' /home/mangos/run/etc/mangosd.conf
  #sed -i -e 's/BindIP = \"0.0.0.0\"/BindIP = \"$pub_ip\"/g' /home/mangos/run/etc/mangosd.conf
  mv /home/mangos/mangos/src/realmd/realmd.conf.dist.in /home/mangos/run/etc/realmd.conf
  sed -i -e 's/127.0.0.1;3306/db;3306/g' /home/mangos/run/etc/realmd.conf
  mv /home/mangos/mangos/src/game/AuctionHouseBot/ahbot.conf.dist.in /home/mangos/run/etc/ahbot.conf
  sed -i -e 's/AuctionHouseBot.Seller.Enabled = 0/AuctionHouseBot.Seller.Enabled = 1/g' /home/mangos/run/etc/ahbot.conf

  # creating an empty file used to check for first run
  touch /home/mangos/run/etc/done_first_run

fi

# Adding mangos lib to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/mangos/run/lib/:$LD_LIBRARY_PATH

# Starting the server
/usr/bin/supervisord

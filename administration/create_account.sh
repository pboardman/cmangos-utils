#!/bin/bash

# Loading config
for line in $(cat config)
do
  if [[ "$(echo $line | cut -d'=' -f1)" == "db_ip" ]]
  then
    db_ip="$(echo $line | cut -d'=' -f2)"
  fi

  if [[ "$(echo $line | cut -d'=' -f1)" == "db_username" ]]
  then
    db_username="$(echo $line | cut -d'=' -f2)"
  fi

  if [[ "$(echo $line | cut -d'=' -f1)" == "db_password" ]]
  then
    db_password="$(echo $line | cut -d'=' -f2)"
  fi
done


if [ $# -eq 0 ]
then
  echo "[Username for the new account]: "
  read username

  echo "[Password for the new account]: "
  read -s password

  echo "[GM level (0,1,2,3)]: "
  read gmlevel
fi

# Creating the account
query="INSERT INTO account (username, sha_pass_hash, gmlevel, last_login) VALUE ('$username', SHA1(CONCAT(UPPER('$username'), ':', UPPER('$password'))),$gmlevel, '2006-04-25')"

mysql -h$db_ip -u$db_username -p$db_password realmd <<< $query

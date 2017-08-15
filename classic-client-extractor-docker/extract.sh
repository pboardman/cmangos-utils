#!/bin/bash

cd /opt

# Cloning repos
git clone git://github.com/cmangos/mangos-classic.git mangos

# Creating build and run folders
mkdir build
mkdir run

# Compiling
cd /opt/build

cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../run -DBUILD_EXTRACTORS=ON -DBUILD_GAME_SERVER=OFF -DBUILD_LOGIN_SERVER=OFF
make
make install

# Copying everything where they needs to be
cp /opt/run/bin/tools/* /opt/
cp /opt/mangos/contrib/extractor_scripts/* /opt/

# replace read line to be able to use the script automatically
sed -i s/read\ line/line=2/g /opt/ExtractResources.sh

chmod +x /opt/ExtractResources.sh
chmod +x /opt/MoveMapGen.sh

cd /opt
./ExtractResources.sh a

mv vmaps output/
mv mmaps output/
mv maps  output/
mv dbc   output/

echo "Done!"

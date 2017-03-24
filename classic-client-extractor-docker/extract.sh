#!/bin/bash

cd /opt

# Cloning repos
git clone git://github.com/cmangos/mangos-classic.git mangos

# Creating build and run folders
mkdir build
mkdir run

# Compiling
cd /opt/build

cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../run -DBUILD_EXTRACTOR=ON -DBUILD_VMAP_EXTRACTOR=ON -DBUILD_MMAP_EXTRACTOR=ON -DBUILD_CORE=false -DDEBUG=0
make
make install

# Copying everything where they needs to be
cp /opt/run/bin/tools/* /opt/
cp /opt/mangos/contrib/extractor_scripts/* /opt/

# ExtractRessources.sh does not use the right vmap_extractor binary
sed -i s/vmapExtractor/vmap_extractor/g /opt/ExtractResources.sh
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

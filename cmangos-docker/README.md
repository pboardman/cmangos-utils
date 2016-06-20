# CMaNGOS Classic inside docker

These files are used to create a CMaNGOS server inside a docker container



## How to

You first need to extract the maps, vmaps, mmaps and dbc from your WoW client [some info here](https://github.com/cmangos/mangos-classic/tree/master/contrib/extractor_binary) to the folder where the Dockerfile is.

Then just run ```docker-compose up``` and it will spin up a cmangos container and a MariaDB container to host the data. (Obviously you need docker and docker-compose for this)

The default GM account is: 

username: GM password: password1234
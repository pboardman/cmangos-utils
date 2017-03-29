# CMaNGOS Classic inside docker

These files are used to create a CMaNGOS server docker image.

## How to

First, clone this repository and either follow the instructions using the CMaNGOS image on Dockerhub or the instructions where you build your own CMaNGOS image.

### Using the image on Dockerhub

Run ` docker-compose up ` and it will start up a CMaNGOS container, a PHP container with a webpage where you can create an account and a MySQL container to host all the data.

### Building the CMaNGOS image yourself

You first need to extract the maps, vmaps, mmaps and dbc from your WoW client [some info here](https://github.com/cmangos/mangos-classic/tree/master/contrib/extractor_binary) and place them in the cmangos-docker folder (if you don't want to extract them manually you can use [this docker image](../classic-client-extractor-docker))

in the ` docker-compose.yml ` comment the line ` image: lacsap/cmangos-classic-server ` and uncomment the line ` #build: .  `

Run ` docker-compose up ` to build the CMaNGOS container and start up the CMaNGOS container, a NGINX container with a webpage where you can create an account and a MySQL container to host all the data.

## Defaults

The default GM account is:

username: GM password: password1234

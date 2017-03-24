# classic-client-extractor-docker

This docker image will generate all maps, mmaps, vmaps and dbc for the latest
version of [CMaNGOS Classic](https://github.com/cmangos/mangos-classic).

## Usage

### Using the image on Dockerhub
Simply run: `docker run --rm -v=/SOMEWHERE/ON/YOUR/MACHINE:/opt/output lacsap/cmangos-classic-client-extractor `

Docker will spin a container. (with the WoW client data already inside) It will
then download the latest [CMaNGOS Classic](https://github.com/cmangos/mangos-classic) version, compile the extracting tools and extract everything to the path you entered in the docker command (the `SOMEWHERE/ON/YOUR/MACHINE` part)

The container will be deleted automatically when it's done extracting everything.


### Building the image yourself
Using the Dockerhub image is way easier but if you want to build the image yourself
you need to:
- Copy the `Data/` directory from a WoW client installation to the directory with the
Dockerfile
- Run `docker build -t IMAGE_NAME .`
- Run `docker run --rm -v=/SOMEWHERE/ON/YOUR/MACHINE:/opt/output IMAGE_NAME `

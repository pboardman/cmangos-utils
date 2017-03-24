############################################################################
# Dockerfile to build a Classic client extractor (maps mmaps vmap dbc) image
############################################################################
FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y build-essential gcc g++ automake git-core \
autoconf make patch libmysql++-dev libtool mysql-client supervisor \
libssl-dev grep binutils zlibc libc6 libbz2-dev cmake subversion libboost-all-dev curl dnsutils

# Split into multiple layer to make uploading to Dockerhub easier
ADD Data/backup.MPQ /opt/Data/
ADD Data/base.MPQ /opt/Data/
ADD Data/dbc.MPQ /opt/Data/
ADD Data/fonts.MPQ /opt/Data/
ADD Data/interface.MPQ /opt/Data/
ADD Data/misc.MPQ /opt/Data/
ADD Data/model.MPQ /opt/Data/
ADD Data/patch.MPQ /opt/Data/
ADD Data/patch-2.MPQ /opt/Data/
ADD Data/sound.MPQ /opt/Data/
ADD Data/speech.MPQ /opt/Data/
ADD Data/terrain.MPQ /opt/Data/
ADD Data/texture.MPQ /opt/Data/
ADD Data/wmo.MPQ /opt/Data/

ADD extract.sh /extract.sh

RUN chmod +x /extract.sh
RUN mkdir /opt/output

VOLUME ["/opt/output"]

CMD ["/extract.sh"]

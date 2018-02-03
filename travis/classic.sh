#!/bin/bash

cd lacsap/cmangos-classic cmangos-classic-docker/

echo "Building cmangos classic image"
docker build -t lacsap/cmangos-classic .

echo "starting the containers"
docker-compose up -d

echo "Waiting until the server is up"
sleep 60

if [ $(docker logs cmangos-classic-server 2> /dev/null | grep -q "realmd entered RUNNING state, process has stayed up for > than 1 seconds") == 0 -a\
     $(docker logs cmangos-classic-server 2> /dev/null | grep -q "mangosd entered RUNNING state, process has stayed up for > than 1 seconds") == 0 ] ; then
    echo "server is up! Test OK"
else
    echo "server not working. Test Failed"
fi
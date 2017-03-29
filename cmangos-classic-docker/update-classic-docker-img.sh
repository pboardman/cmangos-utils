#!/bin/bash

cd "$(dirname "$0")"

echo "Generating maps, mmaps, vmaps and dbc..."
docker run --rm -v $(pwd):/opt/output lacsap/cmangos-classic-client-extractor

echo "Building the lacsap/cmangos-classic image"
docker build -t lacsap/cmangos-classic .

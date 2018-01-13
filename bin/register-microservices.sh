#!/usr/bin/env sh

echo "registering microservices"

curl -X POST 'http://0.0.0.0:8001/apis/' \
     -d 'name=demogo' \
     -d 'upstream_url=http://ms-demo-golang:7701' \
     -d 'uris=/demogo'

curl -X POST 'http://0.0.0.0:8001/apis/' \
     -d 'name=demonode' \
     -d 'upstream_url=http://ms-demo-node:7702' \
     -d 'uris=/demonode'     
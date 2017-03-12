#!/bin/sh

echo "registering microservices"

curl -X POST 'http://0.0.0.0:8001/apis/' \
     -d 'name=demogo' \
     -d 'upstream_url=http://ms-wkspc-demo-golang:7701' \
     -d 'uris=/demogo'
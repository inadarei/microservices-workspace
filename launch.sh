#!/usr/bin/env bash

docker-compose -f ms-demo-golang/docker-compose.yml \
 -f ms-demo-node/docker-compose.yml \
 -f docker-compose.yml up --build -d
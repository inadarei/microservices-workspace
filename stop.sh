#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

docker-compose -f ms-demo-node/docker-compose.yml down
docker-compose -f ms-demo-golang/docker-compose.yml down
docker-compose -f docker-compose.yml down
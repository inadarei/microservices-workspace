#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

docker-compose -f ms-demo-node/docker-compose.yml up --build -d
docker-compose -f ms-demo-golang/docker-compose.yml up --build -d
docker-compose -f docker-compose.yml up --build -d
#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

export wkdr=$PWD
cd $wkdr/ms-demo-node && make start
cd $wkdr/ms-demo-golang && make start

# cd $wkdr && docker-compose up --build -d
cd $wkdr && make startkong
unset wkdr

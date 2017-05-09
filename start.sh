#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

export wkdr=$PWD
cd $wkdr/ms-demo-node && docker-compose up --build -d
cd $wkdr/ms-demo-golang && docker-compose up --build -d
cd $wkdr && docker-compose up --build -d
unset wkdr

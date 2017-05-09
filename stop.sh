#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

export wkdr=$PWD
cd $wkdr/ms-demo-node && docker-compose down
cd $wkdr/ms-demo-golang && docker-compose down
cd $wkdr && docker-compose down
unset wkdr
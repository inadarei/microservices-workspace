#!/usr/bin/env bash

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

export wkdr=$PWD
cd $wkdr/ms-demo-node && make stop
cd $wkdr/ms-demo-golang && make stop

cd $wkdr
make proxystop
unset wkdr

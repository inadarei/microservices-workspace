#!/usr/bin/env bash
set -eu

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

pushd ms-demo-node && make stop
popd
pushd ms-demo-golang && make stop
popd 

make proxystop

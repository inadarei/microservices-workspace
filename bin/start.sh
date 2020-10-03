#!/usr/bin/env bash
set -eu

export COMPOSE_PROJECT_NAME=microservices-workspace-demo

pushd ms-demo-node && make start
popd
pushd ms-demo-golang && make start
popd

make proxystart


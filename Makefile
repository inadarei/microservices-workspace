project:=ms-workspace-demo

ifeq ($(OS),Windows_NT)
	CHECKOUT_BIN:=bin/checkout.exe
else
	UNAME_S:=$(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		CHECKOUT_BIN:=bin/checkout-linux
	endif
	ifeq ($(UNAME_S),Darwin)
		CHECKOUT_BIN:=bin/checkout-mac
	endif
endif

.PHONY: default
default: update start

.PHONY: start
start: 
	- ./bin/start.sh

.PHONY: stop
stop: 
	- ./bin/stop.sh

.PHONY: update
update:
	- @${CHECKOUT_BIN}

.PHONY: ps
ps:
	- @docker ps -a --format="table {{ .ID }}\\t{{ .Names }}\\t{{ .Status }}\\t{{ .Image }}\\t{{ .Ports }}" -f network=${project}_default

.PHONY: proxystart
proxystart:
	docker-compose -p ${project} up -d

.PHONY: proxystop
proxystop:
	docker-compose -p ${project} down

.PHONY: logs
logs:
	docker-compose -p ${project} logs -t

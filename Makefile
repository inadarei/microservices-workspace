default: start

project:=ms-workspace-demo

.PHONY: start
start:
	./start.sh

.PHONY: stop
stop:
	./stop.sh

.PHONY: startkong
startkong:
	docker-compose -p ${project} up -d

.PHONY: stopkong
stopkong:
	docker-compose -p ${project} down

.PHONY: logs
logs:
	docker-compose -p ${project} logs -t

.PHONY: ps
ps:
	docker-compose -p ${project} ps

.PHONY: update
update:
	- git submodule foreach --recursive 'git submodule sync'
	- git submodule update --recursive
	- git submodule update --init --recursive --remote --merge

.PHONY: add
add:
	git submodule add -b master https://github.com/${repo} ${repo}

.PHONY: register_microservices
register_all:
	./register-microservices.sh

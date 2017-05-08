default: start

.PHONY: run
start: 
	./launch.sh

.PHONY: stop
stop: 
	./stop.sh

.PHONY: logs
logs: 
	docker-compose logs -t

.PHOMY: update
update:
	git submodule update --init --recursive

.PHONY: add
add:
	git submodule add -b master https://github.com/${repo} ${repo}

.PHONY: register_microservices
register_all:
	./register_microservices.sh
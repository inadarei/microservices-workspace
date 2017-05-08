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

.PHONY: add
add:
	git submodule add -b master https://github.com/${repo} ${repo}

.PHONY: register_microservices
register_all:
	./register_microservices.sh
default: build

.PHONY: build
build:
	docker-compose build --no-cache 

.PHONY: run
run: 
	./launch.sh

.PHONY: destroy
destroy: 
	docker-compose down

.PHONY: logs
logs: 
	docker-compose logs -t

.PHONY: add
add:
	git submodule add -b master https://github.com/${repo} ${repo}

.PHONY: register_microservices
register_microservices:
	./register_microservices.sh
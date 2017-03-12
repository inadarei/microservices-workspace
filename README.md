# microservices-workspace
Example local setup for developing heterogeneous microservices

## Using

To run the entire project with all microservices and databases:

```
> git submodule update --init --recursive

# Bring everything up in daemon mode. Remove "-d" to debug
> docker-compose up -d
# Make sure everything started fine:
> docker-compose ps
# Register individual microservices with the API Gateway (Kong):
> ./register-microservices.sh
```

To tear-down the project:

```
> docker-compose stop
> docker-compose rm -f 
```

## How to add more microservices:

Example command:

```
> git submodule add -b master git@github.com:inadarei/microservices-workspace-ms-demo-golang.git ms-demo-golang
```
# microservices-workspace
Example local setup for developing heterogeneous microservices

## Installing

To run the entire project with all microservices and databases:

```
> git clone https://github.com/inadarei/microservices-workspace.git && cd microservices-workspace
> git submodule update --init --recursive

# Bring everything up in daemon mode. 
> docker-compose up -d && docker-compose logs -f

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

## Using

## How to add more microservices:

Example command:

```
> git submodule add -b master git@github.com:inadarei/microservices-workspace-ms-demo-golang.git ms-demo-golang
```

# Wiring new service into the Kong API Gateway

1. Add a link to the corresponding container, from the 
   `links` section of the kong container definition, next
   to existing definitions under docker-compose.yml, such as:

   ```
   links:
     - ms-wkspc-demo-golang
     - ms-wkspc-demo-node
   ```

2. Add call registering the service into Kong to register-microservices.sh
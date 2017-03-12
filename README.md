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

1. Once everything is properly installed various microservices can be
   accessed with sub-routes of the API Gateway's URI. In the out-of-the-box
   installation, you get two microservices respectively at:

   ```
   > curl http://0.0.0.0:8000/demogo
   # and
   > curl http://0.0.0.0:8000/demonode
   ```

   If you want Kong to run on a port different from 8000, you can change
   the value in dockor-compose.yml, for instance to make it run on port 80:

   ```
   ports:
     - 80:8000
   ```

## How to add more microservices:

Example command:

```
> git submodule add -b master git@github.com:inadarei/microservices-workspace-ms-demo-golang.git ms-demo-golang
```

# Wiring a new service into the Kong API Gateway

1. Add a link to the corresponding container, from the 
   `links` section of the kong container definition, next
   to existing definitions under docker-compose.yml, such as:

   ```
   links:
     - ms-wkspc-demo-golang
     - ms-wkspc-demo-node
   ```

2. Add call registering the service into Kong to register-microservices.sh
3. Pat attention to PORT environmental variable and `expose` attribute in service's
   Dockerfile and the main docker-compose.yml. These arguments are key for
   making sure proper upstream port is provided to the Kong API Gateway
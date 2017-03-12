# microservices-workspace
Example local setup for developing heterogeneous microservices.

In this setup we show:

1. A microservcie written in Go and set up with code hot-reloading for 
   comfortable development. 
2. A microservice written in Node and similarly set up with code hot-reloading
3. A Kong-based API gateway wiring microservices to various routes so that
   the clients don't need to know about and hardcode their calls against multiple 
   ports the microservices actualy serve from. Kong saves its state in a Postgres database.
4. Resilient set-up of database that a microservice can use (MySQL for the sake of the demo).
   Database setup uses Docker volumes and survives container restarts/crashes.
5. Each microservice is checked into their own Git repository. This main repository 
   you are currently viewing simply orchestrates creation of a single "workspace" 
   point, from which all developers can grab the entire project and easily build it.

As systems get large you may not want to use single workspace for the entire project.
Especially in case of large and advanced microservices deployments where companies find
themselves running hundreds of services. However, this simple approach is very convenient
for sub-systems, subdomains of a larger system, where services are still very much
related and developed by a single team or collaborating teams. To access services 
in other, less related sub-systems of an enterprise deployment, a lot of teams treat 
them on par with external APIs and just access stable production or sandbox versions
of those services. 

We assume that you will use your own judgement about what services to pull-in as submodules
and which to treat as "external dependencies". Loosely coupled approach of submodules
gives a lot of flexibility in making such judgement calls.

**ATTENTION:** unfortunately, git doesn't update external submodules when they change
so we highly recommend running `git submodule update --init --recursive` in the
main repo, frequently.

## Prerequisites:

A working Docker setup, which you can get relatively easily at this point 
on Mac and Windows: https://www.docker.com/community-edition and has always
been [straighforward on Linux](https://docs.docker.com/engine/installation/#platform-support-matrix).

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

2. **ATTENTION:** unfortunately, git doesn't update external submodules when they change
so we highly recommend running `git submodule update --init --recursive` in the
main repo, frequently. 

## How to add more microservices:

Example command:

```
> git submodule add -b master \
      git@github.com:inadarei/microservices-workspace-ms-demo-golang.git \
      ms-demo-golang
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
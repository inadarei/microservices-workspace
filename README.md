# microservices-workspace
Example local setup for developing heterogeneous microservices.

In this setup we show:

1. A microservcie written in Go and set up with code hot-reloading for
   comfortable development. 
2. A microservice written in Node and similarly set up with code hot-reloading
3. A [Traefik](https://traefik.io/)-based frontend reverse-proxy wiring microservices to various 
   routes so that the clients don't need to know about, and/or hardcode their 
   calls against, multiple ports the microservices actualy serve from. 
4. Resilient set-up of database that a microservice can use (MySQL for the sake
   of the demo). Database setup uses Docker volumes and survives container
   restarts/crashes.
5. Each microservice is checked into their own Git repository. This main
   repository you are currently viewing simply orchestrates creation of a single
   "workspace" point, from which all developers can grab the entire project and
   easily build it.

This approach allows developers to easily switch between working on just a
specific microservice and a larger "project space".

As systems get large you may want to have more than one project space. That is a
decision you would take based on your unique needs. However, this blueprint
workspace provides a lot of recipes to get you on the journey of breaking-up and
composing work as you see fit and creating an enjoyable, yet simple development
workspace.

## Prerequisites:

A working Docker setup, which you can get pretty easily for most major platforms
like Mac, Windows and Linux flavors:
<https://www.docker.com/community-edition#/download> 

## Installing

To run the entire project with all microservices and databases:

```
> git clone https://github.com/inadarei/microservices-workspace.git && cd microservices-workspace

# Bring everything up in daemon mode: 
> make

# Make sure everything started fine:
> make ps
```

To tear-down the project:

```
> make stop
```

## Using

Once everything is properly installed various microservices can be accessed at
sub-routes of the front-end reverse proxy's URI. In the out-of-the-box installation, 
you get two microservices respectively at:

```
> curl http://ms-demo-node-ms-workspace-demo.docker.localhost:9080/
# and
> curl http://ms-demo-golang-ms-workspace-demo.docker.localhost:9080/
```

Please note that "ms-demo-node-ms-workspace-demo" and "ms-demo-golang-ms-workspace-demo"
are the automatically-detected hostnames (subdomains) generated from the microservice
container names (`ms-demo-node` and `ms-demo-golang`) and the Docker 
project namespace: `ms-workspace-demo`.

These hostname can be overwritten using more specific labels in the docker-compose
file of corresponding microservices, for example by placing something like the 
following in `ms-demo-node/docker-compose.yaml`:

```yaml
labels:
    - "traefik.http.routers.ms-demo-node.rule=Host(`demonode.docker.localhost`)"
```

which would allow demo node microservice to be available by invoking a shorter
URL, along the lines of: `curl http://demonode.docker.localhost:9080/`

If you want the project to run on a port different from 9080, you can change
the value in the topmost
[dockor-compose.yml](https://github.com/inadarei/microservices-workspace/blob/master/docker-compose.yml).
For instance, to make it run on port 80:

```
ports:
  - "80:80"
```

## Service Discovery – Traefik

**Q:** How are microservices discovered by the front-end proxy?

**A:** The workspace uses a modern, highly capable proxy:
[Traefik](https://docs.traefik.io/) which automatically discovers services in
your project and wires them up to the proper sub-routes.

Once you have the project up, you can access the web UI of the proxy at:
http://0.0.0.0:9880/

## How to add more microservices:

- Edit config/repos.json
- Run `make update` in the topmost repository to get the new codebase
- Edit start.sh and stop.sh scripts under ./bin to add start and stop
  commands for the new module. Existing commands should be used as a guide.
- Make sure the docker-compose file for the service has labels required
  by Traefik 
  
  example: <https://github.com/inadarei/microservices-workspace-ms-demo-node/blob/master/docker-compose.yml#L6>)
- Make sure the docker-compose commands are starting your new service
  in the same project as the Traefik and the rest of the services

  example: <https://github.com/inadarei/microservices-workspace-ms-demo-node/blob/master/Makefile#L3> 


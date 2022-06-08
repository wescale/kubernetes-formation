# exercise-1: Build a Docker image

The application is a web server which counts each HTTP request and returns this counter.

The components are:
- a NodeJS application which uses the [Express](http://expressjs.com/) framework
- a [Redis](http://redis.io/) NoSQL database to persist the counter of requests


## Start the Redis container

Start a container named `redis` from the `redis:latest` image.

## Create a user-defined bridge network

```sh
  docker network create my-net
```
## Connect the redis container to your user-defined bridge network

```sh
  docker network connect my-net redis
```

## Build an image for the NodeJS app

The aim of this step is to complete the given Dockerfile to build the NodeJS application.

Once you completed the Dockerfile, build the image:
```sh
  docker build -t myrepo/nodeapp .
```


## Launch the application


The aim of this step is to run a container with the correct options to:
* connect it to the `my-net` network
* expose a port externally on a host

You can now start the application container to listen on the exposed port.
This container needs to connect to the Redis instance:
```
  docker run -d --name nodeapp ##OptionToConnectThisContainerToMy-Net## ##OptionToExposeThePort## myrepo/nodeapp
```

To test if your application works well, you can consult this page: [http://[BASTION IP]:8080](http://localhost:8080)

## Question

How is the resolution of `redis` done inside the `nodeapp` container?

## Clean the containers

```sh
  docker rm -vf redis
  docker rm -vf nodeapp
  docker network rm my-net
```


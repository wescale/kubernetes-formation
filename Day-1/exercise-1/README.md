# exercise-1: Build a Docker image

The application is a web server which counts each HTTP request and returns this counter.

The components are:
- a NodeJS application which uses the [Express](http://expressjs.com/) framework
- a [Redis](http://redis.io/) NoSQL database to persist the counter of requests

## Start the Redis container

Pull then start the Redis server:
```sh
  docker run -d --name redis redis
```

## Build an image for the NodeJS app

The aim of this step is to complete the given Dockerfile to build the NodeJS application.

Once you completed the Dockerfile, build the image:
```sh
  docker build -t myrepo/nodeapp .
```


## Launch the application


The aim of this step is to run a container with the correct options to:
* link two containers
* expose a port externally on a host

You can now start the application container to listen on the exposed port.
This container needs to connect to the Redis instance:
```
  docker run -d --name nodeapp ##OptionToLinkThisContainerToRedis## ##OptionToExposeThePort## myrepo/nodeapp
```

To test if your application works well, you can consult this page: [http://[BASTION IP]:8080](http://localhost:8080)

## Clean the containers

```sh
  docker rm -vf redis
  docker rm -vf nodeapp
```

## Enhancements

Are you satisfied with the solution to link the containers?

What is your recommendation?

# exercise-2: Fortunately, there is docker-compose

## Prerequisistes: installation of docker-compose

Read the doc : [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

## Instructions

We use the same NodeJS as the one of the precedent exercise.

The aim is to run 2 containers and connect them no more with docker cli but a `docker-compose.yml` file.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

The expected directives are:
* You will indicate in this file the NodeJS application will be built from its Dockerfile.
* The NodeJS application will be connected to the Redis service.
* The Redis service simply start the official image from [Dockerhub](https://hub.docker.com/).

## Launch the application

Once your `docker-compose.yml` written, you can launch the following command to start all the services:
```sh
docker-compose up -d
```

To test if your application works well, you can consult this page: [http://[BASTION IP]:8080](http://localhost:8080)

## Question

How is the address resolution performed from the NodeJS container?

## Clean

You can stop all the containers started by docker-compose:
```sh
docker-compose stop
```

Then delete all the containers:
```sh
docker-compose rm
```

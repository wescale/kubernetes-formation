# Exercise 4: Manage multiple containers with docker-compose

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

We use the same application as the one of the previous exercise.

The aim is to run 2 containers and connect them without running docker cli but a `docker-compose.yml` file.

To do that, you get a `docker-compose` skeleton file. You must complete the file with the correct instructions.

## Prerequisites

Docker compose is already installed in the CloudShell default image.

On a classical server, you should install it: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/).

## Launch the application

Complete the <walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file> file.

The expected directives are:
* The `article-svc` application:
  * use the `alphayax/microservice-demo-article-service:latest` image 
  * specify the `MONGODB_URI` environment variable with the value `mongodb://mongo:27017`
* The `mongo` service simply starts the official image from [Dockerhub](https://hub.docker.com/).

Please consult the [Docker Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) if you need help.

You can launch the following command to start all the services:

```sh
docker compose up -d
```

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon: It should return an empty json array.

### Add a frontend

You can add a frontend to the application. To do that, we'll use the `alphayax/microservice-demo-frontend-admin:latest` image.

## Question

How is the address resolution performed from the NodeJS container?

## Clean

You can stop all the containers started by docker-compose:

```sh
docker compose stop
```

Then delete all the containers:

```sh
docker compose rm
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

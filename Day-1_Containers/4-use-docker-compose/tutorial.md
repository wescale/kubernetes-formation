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
  * use the `europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:latest` [image](https://github.com/compose-spec/compose-spec/blob/master/spec.md#image) 
  * Specify the `MONGODB_URI` [environment](https://github.com/compose-spec/compose-spec/blob/master/spec.md#environment) variable with the value `mongodb://mongo:27017`
  * [Bind](https://github.com/compose-spec/compose-spec/blob/master/spec.md#ports) the port **8080** inside the container to the port **8080** on the Docker host
* The `mongo` service simply starts the official image from [Dockerhub](https://hub.docker.com/).

Please consult the [Docker Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) if you need help.

You can launch the following command to start all the services:

```sh
docker compose up -d
```

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> 
icon: It should return a json with the following content: 

```json
{
  "articles": null
}
```

You can stop and clean your stack with the following command:

```sh
docker compose down
```

## Question

How is the address resolution performed from the `article-service` container?

## Add a frontend

Add a new service named `frontend-admin`
- use the `europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-admin:latest` image. 
- Remove the port mapping for the `article-svc` service.
- Add the following port mapping for the `frontend-admin` service: `8080:80`.

Once it's done, you can restart your new stack with your 3 services.

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon>
icon: You should see the admin frontend page... Unfortunately, it's broken... The frontend cannot contact the API.
We'll need to do some more work to fix it. And we'll do in the next chapter :)

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

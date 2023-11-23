# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the build of docker images.

We'll use a basic golang program and will see how to build a docker image from it.

## A basic GoLang application

The application is a simple program that write a message in the standard output.

You can take a look at the <walkthrough-editor-open-file filePath="go-app/main.go">main.go</walkthrough-editor-open-file> file.

You can edit this file to change the message, or add more features to the application (But stay basic, we don't want to spend too much time on this part)

### Build the application

To build the application, you just need to run the following command:
```sh
go build -o main go-app/main.go
```

> This command will build an executable named `main` with the code inside the `go-app`.

Then, you can run the application to test it:
```sh
./main
```

### Containerize the application

To build the containerized application, we need to specify the commands to build the image in the 
<walkthrough-editor-open-file filePath="Dockerfile">Dockerfile</walkthrough-editor-open-file> file.

> See the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/#dockerfile-reference) for help.

The dockerfile will do these main steps :
- We'll use the `golang:1.20` image as base image.
- Then, we'll copy the `go-app` folder inside the container.
- Finally, we'll build the application inside the container.

```sh
docker build -t go-app:latest .
```

Then, you can test the containerized application:
```sh
docker run go-app:latest
```


## A true golang application

Now, we'll use a more complex golang application.

To do that you can checkout the code from the GitHub repository with the following command:

```sh
git clone https://github.com/alphayax/microservices-demo.git
```

> A new folder named **microservices-demo** will be created.

Then, you can take a look at the <walkthrough-editor-open-file filePath="microservices-demo/article-service/Dockerfile">Dockerfile</walkthrough-editor-open-file> file.
You'll see a [multi-stage](https://docs.docker.com/build/building/multi-stage/) build.

### Containerize the application

Build the image, and run it.

> What do you see ?

---

First, enter the commands to start a container named `redis` from the `redis:latest` image.

Then, you will create a new docker network named `my-net`:

```sh
docker network create my-net
```

Finally, you will connect the `redis` container to the `my-net` network:

```sh
docker network connect my-net redis
```

## Build an image for the cart microservice

First of all, you need to get the microservice code. You can checkout it from the GitHub repository with the 
following command:

```sh
git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
```

Once the clone done, you can check the related 
<walkthrough-editor-open-file filePath="microservices-demo/src/cartservice/src/Dockerfile">Dockerfile</walkthrough-editor-open-file> 
used to build the microservice. 

> The cart service code is in the `microservices-demo/src/cartservice/src/` folder.
>
> See the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) for help.

Navigate to the source folder:
```sh
cd microservices-demo/src/cartservice/src/
```

Then, build the image:
```sh
docker build -t cartservice:latest .
```

## Launch the cart microservice

The aim of this step is to run a `cartservice` container with the correct options to:
* connect it to the `my-net` network
* specify the redis endpoint with the `REDIS_ADDR` environment variable

Complete the following command line to add the correct options:

```sh
docker run \
  -d \
  --name cartservice \
  OPTION_TO_CONNECT_THIS_CONTAINER_TO_MY-NET \ 
  OPTION_TO_ADD_REDIS_ADDR_ENVIRONEMENT_VARIABLE \
  cartservice:latest
```

To test if your application works well, you can check the logs of the `cartservice` container.

```sh
docker logs cartservice
```

> If you see the following line:
> `Redis cache host(hostname+port) was not specified. Starting a cart service using in memory store`
> this means you didn't specify the redis endpoint correctly.

## Question

How is the resolution of `redis` done inside the `cartservice` container?

## Clean the containers

```sh
docker rm -vf redis
docker rm -vf cartservice
docker network rm my-net
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

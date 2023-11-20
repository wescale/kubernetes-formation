# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the build of docker images.

We'll use the [microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo) project from Google.

For now, we'll only use the "cart store" service, and connect it to a redis database. To summary, we'll have : 
* The "cart store" microservice
* a [Redis](http://redis.io/) NoSQL database to persist the store cache

## Start the Redis container

Enter the commands to start a container named `redis` from the `redis:latest` image.

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
<walkthrough-editor-open-file filePath="microservice-demo/src/cartservice/src/Dockerfile">Dockerfile</walkthrough-editor-open-file> 
used to build the microservice.

See the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) for help.

Once you have read the Dockerfile, build the image:

```sh
# Go the the correct folder
cd microservice-demo/src/cartservice/src/

# Then, build the dockerfile
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

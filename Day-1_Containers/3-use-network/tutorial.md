# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the docker networks.

We'll use this [Microservice demo project](https://github.com/alphayax/microservices-demo) as example.

In the previous lab, we build the `article-service` image. Hopefully, we'll not have to rebuild it because it's already 
built and pushed to dockerhub. You can retrieve the image with the following command:

```bash
docker pull alphayax/microservice-demo-article-service
```

The goal of this exercise will be to add the missing configuration to the article-service and connect it to a mongodb instance.

## The mongodb container

### Run the mongodb container

Find the official mongodb image on [dockerhub](https://hub.docker.com/search?q=mongodb). Once it's done, run it:
- By giving to the container the `--name` **mongo**.
- By detaching `-d` the container from the standard output.

### Create the `my-net` network

Create a new docker network named `my-net`:
```sh
docker network create my-net
```

Finally, connect the `mongo` container to the `my-net` network:
```sh
docker network connect my-net mongo
```

## The article-service container

The aim of this step is to `run` an **article-svc** container with the correct options to:
- Give him the name **article-service**
- Connect it to the **my-net** network (`--network`)
- Specify the mongodb endpoint with the `MONGODB_URI` environment (`-e`) variable

If you detached the article-service container, you can follow the logs with the command:
```sh
docker logs -f article-svc
```

If you've done the job correctly, the service will not crash and will wait incoming connections on port 8080

## Question

How is the resolution of `mongo` done inside the `article-svc` container?

## Clean the containers

```sh
docker rm -vf mongo
docker rm -vf article-svc
docker network rm my-net
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

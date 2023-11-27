# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the docker networks.

We'll use this [Microservice demo project](https://github.com/alphayax/microservices-demo) as example.

In the previous lab, we build the `article-service` image. Hopefully, we'll not have to rebuild it because I already 
built-it and push-it to dockerhub. 

You can retrieve the image with the following command:

```bash
docker pull alphayax/microservice-demo-article-service
```

The goal of this exercise will be to add the missing configuration to the **article-service** and connect it to a **mongodb** instance.

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


> You can check the **my-net** network by using the `docker network inpsect my-net` command. For more help about docker 
network commands, use `docker help network`.

## The article-service container

Now, `run` an **article-svc** container with the correct options to:
- Use the image `alphayax/microservice-demo-article-service:latest`
- Give him the name **article-service**
- Connect it to the **my-net** network (`--network`)
- Specify the mongodb endpoint (`mongodb://mongo:27017`) with the `MONGODB_URI` environment variable (`-e`)

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
docker rmi mongo
docker rmi alphayax/microservice-demo-article-service:latest
docker network rm my-net
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
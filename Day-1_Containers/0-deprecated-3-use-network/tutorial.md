# Exercise 3 - Use network

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must login on the GCP registry:

```sh
gcloud auth login
gcloud auth configure-docker europe-west1-docker.pkg.dev
```

## Description

In this exercise you will get familiar with the docker networks.

We'll use this [Microservice demo project](https://github.com/wescale/microservices-demo) as example.

In the previous lab, we build the `article-service` image. Hopefully, we'll not have to rebuild it because it's already 
built and pushed to GCP registry. 

You can retrieve the image with the following command:

```bash
docker pull europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:1.0.0
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


> You can check the **my-net** network by using the `docker network inspect my-net` command. 

> For more help about docker network commands, use `docker help network`.

## The article-service container

Now, `run` an **article-svc** container with the correct options to:
- Use the image `europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:1.0.0`
- Give him the name **article-service**
- Connect it to the **my-net** network (`--network`)
- Specify the mongodb endpoint (`mongodb://mongo:27017`) with the `MONGODB_URI` environment variable (`-e`)

If you detach (`-d`) the article-service container, you can follow the logs with the command:
```sh
docker logs -f article-service
```

If you've done the job correctly, the service will not crash and will wait incoming connections on port 8080

## Question

How is the resolution of `mongo` done inside the `article-svc` container?

## Clean the containers

Remove the `mongo` and the `article-service` container:
```sh
docker rm -vf mongo article-service
```

Remove the `mongo` and the `article-service` image:
```sh
docker rmi mongo europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:1.0.0
```

Remove the `my-net` network:
```sh
docker network rm my-net
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

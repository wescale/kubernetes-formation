# first-commands

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

This exercise will familiar yourself with Docker engine.

On [Google Cloud Shell](https://cloud.google.com/shell), Docker engine is already installed.

On classical server, you would need to [install it](https://docs.docker.com/engine/install/).

## Docker info

### Get engine and client information

Run **docker info** to get various information about the client and engine configuration.

```sh
docker info
```

What are the number of CPU and the memory capacity of or host?

## Launch your first container

```sh
docker run hello-world
```

Observe the produced output and answer to the following questions:

* Container image format is IMAGE:TAG. What is the tag used in our case?
* What is the SHA1 used in our case?
* What is the source of the hello-world image?

**docker run** has a huge amount of options.

```sh
docker run --help
```

Look at the  options applicable to limit CPU and memory when a container is started.

## Other Docker commands

Docker has many commands that you can view with:

```sh
docker --help
```

Among those commands, we will look at **ps**, **images**, **inspect**, **history** and **logs**.

### List containers

Determine the status of your hello-world container with:

```sh
docker ps -a
```

We will retrieve the CONTAINER ID for later use.

```sh
CONTAINER_ID=$(docker ps -al --format json|jq -r '.ID')
```

### Inspect Docker objects

**docker inspect** allows to retrieve metadata about various Docker objects and outputs json.

For example, you can inspect the created container:

```sh
docker inspect ${CONTAINER_ID}|jq ''
```

Observe the result to determine:

* What is the executed command?
* What is the hostname saw inside the container?

## Retrieve the logs

You can access the logs of a container with **docker logs**:

```sh
docker logs ${CONTAINER_ID}
```

But you can also access the logs with:

```sh
sudo cat $(docker inspect ${CONTAINER_ID}|jq -r '.[].LogPath')
```

Why are the log formatted in json?

## Images

### First steps with container images

You can list the local images with **docker images**:

```sh
docker images
```

**docker inspect** command can also provide information about the hello-word image.

Get the image id:

```sh
IMAGE_ID=$(docker images --format json|jq -r '.ID')
```

Then inspect it:

```sh
docker inspect ${IMAGE_ID}|jq ''
```

Observe the result to determine:

* What is the value of the **PATH** environment variable?
* What is the default executed command in this image?

### Container image to Dockerfile

You can view the history of command which have been used to create the image.

```sh
docker history ${IMAGE_ID}
```

hello-world image comes from the default registry, called  the [DockerHub](https://hub.docker.com/). This hub serves many images. Some of them are officially maintained, some others are community provided with potential security issues...

Open the [DockerHub](https://hub.docker.com/) and search for the hello-world image.

You can see the list of tags and additional information about the image usage.

To see the related Dockerfile, you must consult the [GitHub repository](https://github.com/docker-library/hello-world/blob/master/amd64/hello-world/Dockerfile)

```none
FROM scratch
COPY hello /
CMD ["/hello"]
```

Do you retrieve the instructions printed with **docker history** command ?

What does the **FROM scratch** directive mean?

## Clean

Clean the container:

```sh
docker rm -vf ${CONTAINER_ID}
```

Then the image:

```sh
docker rmi ${IMAGE_ID}
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

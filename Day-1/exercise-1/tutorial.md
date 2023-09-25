# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the build of docker images.

The application is a web server which counts each HTTP request and returns this counter.

The components are:

* a Python Flask application
* a [Redis](http://redis.io/) NoSQL database to persist the counter of requests

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

## Build an image for the Python Flask app

You need to complete the given <walkthrough-editor-open-file filePath="Dockerfile">Dockerfile</walkthrough-editor-open-file> to build the Python Flask application.

See the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) for help.

Once you have completed the Dockerfile, build the image:

```sh
docker build -t myrepo/pythonapp .
```

Note the number of the port exposed inside the container.

## Launch the Python Flask app

The aim of this step is to run a `pythonapp` container with the correct options to:

* connect it to the `my-net` network
* expose a port externally on the running host

Complete the following command line to add the correct options:

```sh
docker run -d --name pythonapp OPTION_TO_CONNECT_THIS_CONTAINER_TO_MY-NET OPTION_TO_EXPOSE_THE_PORT myrepo/pythonapp
```

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

## Question

How is the resolution of `redis` done inside the `pythonapp` container?

**Tips**: You can execute a `shell` inside the `pythonapp` container running a `docker exec -ti CONTAINER_ID sh` command. Then install dig with `apk add --update bind-tools`

## Clean the containers

```sh
docker rm -vf redis
docker rm -vf pythonapp
docker network rm my-net
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

# Exercise 1 - Build and run an app

<walkthrough-tutorial-duration duration="40.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will get familiar with the build of docker images.

We'll use a basic golang program and will see how to build a docker image from it.

## A basic GoLang application

The application is a simple program that write a message in the standard output.

You can take a look at the <walkthrough-editor-open-file filePath="go-app/main.go">go-app/main.go</walkthrough-editor-open-file> file.

You can edit this file to change the message, or add more features to the application (But stay basic, we don't want to spend too much time on this part)

## Build the application

To build the application, you just need to run the following command:
```sh
go build -o main go-app/main.go
```

> This command will build an executable named `main` with the code inside the `go-app`.

Then, you can run the application to test it:
```sh
./main
```

After the test, Delete the `main` file because it's only purpose was testing the app. This `main` file is not used in the image building process :
```sh
rm ./main
```

## Containerize the application

### The Dockerfile

To build the containerized application, we need to specify the commands to build the image in the 
<walkthrough-editor-open-file filePath="Dockerfile">Dockerfile</walkthrough-editor-open-file> file.

> See the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/#dockerfile-reference) for help.

The dockerfile will do these main steps :
- We'll use the `golang:1.20` image as base image.
- Then, we'll copy the `go-app` folder inside the container.
- Finally, we'll build the application inside the container.

### Create the image

To build a docker image from a `Dockerfile`, you can use the following command: `docker build -t <image-name>:<image-tag> <path-to-context>`
- The `image-name` is the name of the image you want to build.
- The `image-tag` is the tag of the image you want to build.
- The `path-to-context` is the relative folder where the `COPY` and `ADD` command will be resolved.

```sh
docker build -t go-app:latest .
```

Then, you can test the containerized application:
```sh
docker run go-app:latest
```

## A more complex golang application

Now, we'll use a more complex golang application.

To do that you can checkout the code from the GitHub repository with the following command:

```sh
git clone https://github.com/wescale/microservices-demo.git
```

> A new folder named **microservices-demo** will be created.

Then, you can take a look at the <walkthrough-editor-open-file filePath="microservices-demo/article-service/Dockerfile">microservices-demo/article-service/Dockerfile</walkthrough-editor-open-file> file.
You'll see a [multi-stage](https://docs.docker.com/build/building/multi-stage/) build (With 2 `FROM` instructions).

## Containerize the application

### Build the image

Navigate to the `microservices-demo/article-service` folder, then build the image. You can tag the image with the `article-service:latest` tag.


### Run the container

One the image build, run it. It should crash after a few seconds by displaying some error messages regarding a missing configuration.

> We'll fix this problem in the next exercise.

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

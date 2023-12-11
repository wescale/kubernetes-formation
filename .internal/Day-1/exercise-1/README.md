
# Exercise 1: First Docker commands

## Launch your first container

According the following command:
```bash
docker run hello-world
```

And the following output:

```
trainer@cloudshell:~/cloudshell_open/kubernetes-formation-17$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
719385e32844: Already exists
Digest: sha256:c79d06dfdfd3d3eb04cafd0dc2bacab0992ebc243e083cabe208bac4dd7759e0
Status: Downloaded newer image for hello-world:latest
```

Container image format is IMAGE:TAG. What is the tag used in our case?
> latest (line 2 of the output)

What is the SHA used in our case?
> c79d06dfdfd3d3eb04cafd0dc2bacab0992ebc243e083cabe208bac4dd7759e0 (line 5 of the output)

What is the source of the hello-world image?
> library (line 3 of the output)

## Other Docker commands

### Inspect Docker objects

What is the executed command?
```bash
docker inspect ${CONTAINER_ID} | jq .[0].Config.Cmd
```
> The executed command is ["/hello"]

What is the hostname saw inside the container?
```bash
docker inspect ${CONTAINER_ID} | jq .[0].Config.Hostname
```
> The hostname is the container id

## Retrieve the logs

Why are the log formatted in json?
> Because the log driver is `json-file` (See [Documentation](https://docs.docker.com/config/containers/logging/configure/))

## Images

### First steps with container images

What is the value of the PATH environment variable?
```bash
docker inspect ${IMAGE_ID} | jq .[0].Config.Env
```
> `PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin`

What is the default executed command in this image?
```bash
docker inspect ${IMAGE_ID} | jq .[0].Config.Cmd
```

### Container image to Dockerfile
Do you retrieve the instructions printed with docker history command ?
```
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
9c7a54a9a43c   6 months ago   /bin/sh -c #(nop)  CMD ["/hello"]               0B        
<missing>      6 months ago   /bin/sh -c #(nop) COPY file:201f8f1849e89d53…   13.3kB
```
> Yes, we see 2 layers

What does the FROM scratch directive mean ?
> The image is based on an empty image (See [Documentation](https://docs.docker.com/develop/develop-images/baseimages/#create-a-simple-parent-image-using-scratch))

## Dig a little deeper

How could you launch the mongo image to avoid the terminal to be lock on the logs ?
```bash
docker run -d mongo
```
> The `-d` flag (detached mode) will run the container in the background

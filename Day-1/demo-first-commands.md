# Cmd *docker run hello-world*

```sh
docker info
# Comments plugins, CPUs, Total Memory, Storage Driver
````


# Cmd *docker run hello-world*

Clean all images

Clean all containers

```sh
ubuntu@wescale-bastion:~$ docker run hello-world

# Tag latest
# Local registry
Unable to find image 'hello-world:latest' locally
# Remote registry
latest: Pulling from library/hello-world
# Image SHA1 -> docker images hello-world:latest
0e03bdcc26d7: Pull complete
Digest: sha256:8c5aeeb6a5f3ba4883347d3747a7249f491766ca1caa47e5da5dfcf6b9b717c0
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

# Ask who has never gone to the DockerHub
# Go to the DockerHub and mention the starred, tags, Docker files...
# Open and comment the Dockerfile for Linux, Windows ...
Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

# Inside the container

```sh
ubuntu@wescale-bastion:~$ docker ps -a
# Every object has ID in Docker
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
794198f37efa        hello-world         "/hello"            14 minutes ago      Exited (0) 14 minutes ago                       eager_tu

# Then can use the ID with docker inspect, to retrieve a JSON
ubuntu@wescale-bastion:~$ docker inspect 794198f37efa|jq ''
[
  {
    "Id": "794198f37efae8c00816f59ad2bcc6938bf9239ca03445ac257ce0855896e439",
    "Created": "2020-11-05T20:46:38.875017512Z",
    "Path": "/hello",
    "Args": [],
    "State": {
      "Status": "exited",
      "Running": false,
      "Paused": false,
      "Restarting": false,
      ...
```


Interesting fields:    
```sh
CONT_ID=$(docker ls -aq)
docker inspect "${CONT_ID}"|jq '.[].State'
docker inspect "${CONT_ID}"|jq '.[].Config'
# See Hostname

$ docker inspect "${CONT_ID}"|jq '.[].HostConfig'
# See Memory, CpuQuota, CpuPeriod ...

# Retrieve the logs
docker logs "${CONT_ID}"
# Stored here:
sudo cat $(docker inspect "${CONT_ID}"|jq -r '.[].LogPath')

# In fact, container files are located in /var/lib/docker/containers
sudo ls -la /var/lib/docker/containers/XXX
```

# Inside the image

```sh
ubuntu@wescale-bastion:~$ docker images
# Every object has ID in Docker
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              bf756fb1ae65        10 months ago       13.3kB

# Then can use the ID with docker inspect

```



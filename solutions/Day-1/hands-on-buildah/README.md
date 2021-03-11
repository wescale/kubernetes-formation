# Hands-on : build images with Buildah


## Run the simple image


2. Run the container using Docker

```sh
podman push demo-wescale-training docker-daemon:demo-wescale-training:latest
docker run --rm demo-wescale-training:latest
```

## Build with a Dockerfile

```sh
buildah bud -t demo-wescale-training-bud .
podman run --rm demo-wescale-training-bud
```
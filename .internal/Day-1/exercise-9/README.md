
# Exercise 9 : build images with Buildah

## Run the simple image

Run the container using Podman
```sh
podman run --rm demo-wescale-training:latest
```

Run the container using Docker
```sh
docker run --rm demo-wescale-training:latest
```

Do you see your image when typing docker images?
> No

 
## Build with a Dockerfile

How to build it with buildah ?
```sh
buildah bud -t demo-wescale-training-bud .
```

Then, run it:
```sh
podman run --rm demo-wescale-training-bud
```

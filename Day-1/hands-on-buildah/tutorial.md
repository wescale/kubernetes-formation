# Hands-on : build images with Buildah

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will use buildah to create container images.

You will see in the opposite of docker, buildah does not need a Dockerfile.

---

Inspired from: <https://github.com/containers/buildah/blob/master/demos/>

## Prerequisistes: installation of Buildah & podman

Buildah is already installed with Podman.

Check if everything works (no need of `sudo`):

```sh
buildah version
```

If you need to install Buildah, read the [Buildah Installation](https://github.com/containers/buildah/blob/master/install.md) documentation.

## Build a simple image

```sh
# Create a new container on disk from alpine
newcontainer=$(buildah from alpine)

# Update packages and Install bash
buildah run $newcontainer -- apk -U add bash

# Add a sample script as entrypoint
buildah copy $newcontainer ./runecho.sh /usr/bin
buildah config --entrypoint /usr/bin/runecho.sh $newcontainer

# Inspect the container image meta data
buildah inspect $newcontainer

# Commit the container to an OCI image called demo-wescale-training
buildah commit $newcontainer demo-wescale-training

# List the images we have
buildah images
```

## Run the simple image

1. Run the container using Podman
2. Run the container using Docker
    1. Do you see your image when typing `docker images`?
    2. podman provides an helper to push images to the local Docker registry:

    ```sh
    podman push demo-wescale-training docker-daemon:demo-wescale-training:latest
    ```

## Build with a Dockerfile

See the <walkthrough-editor-open-file filePath="./Dockerfile">Dockerfile</walkthrough-editor-open-file>:

```sh
FROM alpine

RUN apk -U add bash &&\
    echo '#!/usr/bin/env bash' > /usr/bin/entrypoint.sh &&\
    echo 'echo "Hi from Bud!"' >> /usr/bin/entrypoint.sh &&\
    chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh
```

How to build it with `buildah`?

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

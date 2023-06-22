# Hands-on : from Docker to Podman

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will [install  Podman](https://podman.io/getting-started/installation).

Then, you will launch podman commands and see they are similar to docker ones.

## Prerequisistes: installation of Podman

Running the following will generate a warning message because of the ephemeral mode of your Cloud Shell instance:

```sh
sudo apt-get update
sudo apt-get install -y podman
```

Now, configure podman:

```sh
mkdir -p ${HOME}/.config/containers/

cat <<EOF > ${HOME}/.config/containers/containers.conf
[engine]
events_logger = "file"
cgroup_manager = "cgroupfs"
EOF
```

Check if everything works (no need of `sudo`):

```sh
podman ps -a
```

## Launch a web server

You will start an nginx container mounting the <walkthrough-editor-open-file filePath="./src/index.html">src/index.html</walkthrough-editor-open-file> file as a volume towards `/usr/share/nginx/html/index.html`.

Because the default registry with podman is quay.io and not docker.io, you must indicate the registry.

Complete the command line:

```sh
podman run --name nginx -d -p 8080:80 ##OptionToUseAVolume## docker.io/nginx
```

Then preview the web page by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

## See logs

See the logs of the created container.
Use the special flag `--latest`

## Podman is not Docker ...

Watch running `docker` containers. Do you see `nginx`?

## ... but Podman looks very like Docker

`podman` cli has same commands and options as `docker`. Just put an entry in your _.bash_aliases_ can do the trick:

```sh
echo "alias docker=podman" >> .bash_aliases
source .bash_aliases
```

Can you see a running container using `docker` keyword now?

## Clean

You can stop the container and remove it:

```sh
unalias docker
podman stop --latest
podman ps -a
podman rm --latest
podman ps -a
```

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

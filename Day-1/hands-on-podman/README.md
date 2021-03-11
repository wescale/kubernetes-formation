# Hands-on : from Docker to Podman

## Prerequisistes: installation of Podman

Read the doc : [Installation](https://podman.io/getting-started/installation/)

Check if everything works (no need of `sudo`):

```
podman ps -a
```

## Launch a web server

Add a custom /usr/share/nginx/html/index.html using a volume

```
podman run --name nginx -d -p 8080:80 ##OptionToUseAVolume## nginx
```

## Latest flag

Use the special flag `--latest`

## Podman is not Docker ...

Watch running docker containers. Do you see `nginx`?

## ... but Podman looks very like Docker

`podman` cli has same commands and options as `docker`. Just put an entry in your _.bash_aliases_ can do the trick:

```sh
echo "alias docker=podman" >> .bash_aliases
```

Can you see a running container using `docker` keyword now? Don't forget to start a new Bash terminal.

## Clean

You can stop the container and remove it:
```sh
podman stop --latest
podman ps -a
podman rm --latest
podman ps -a
```



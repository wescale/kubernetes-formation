
# Exercise 8 - From Docker to Podman

## Launch a web server

```sh
podman run --name nginx -d -p 8080:80 -v ./src:/usr/share/nginx/html:ro docker.io/nginx
```

## See logs

```sh
podman logs --latest
```

## Podman is not Docker ...

Watch running docker containers. Do you see nginx?
> No.

## ... but Podman looks very like Docker

Can you see a running container using docker keyword now?
> Yes.

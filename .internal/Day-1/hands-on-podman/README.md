
```sh
podman run --name nginx -p 8080:80 -v ./src:/usr/share/nginx/html/ docker.io/nginx

podman logs --latest

docker ps -a
```
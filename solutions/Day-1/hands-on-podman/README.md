
```sh
podman run --name nginx -p 8080:80 -v ./src:/usr/share/nginx/html/ nginx

podman logs --latest

docker ps -a
```
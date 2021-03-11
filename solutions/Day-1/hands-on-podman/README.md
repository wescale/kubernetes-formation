
```sh
podman run --name nginx -p 8080:80 -v /tmp/index.html:/usr/share/nginx/html/index.html nginx

podman logs --latest

docker ps -a
```
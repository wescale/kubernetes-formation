# Exercise-5: Use docker volumes for configuration and persistence

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

We use the same application as the one of the previous exercises. 

In order to handle connections on multiple services on a single port, a
[Nginx reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) have been set up in the
<walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file> file.

The goal here is to add a configuration file inside the frontend container to overwrite the default configuration, and 
add persistence to the mongo database.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## The reverse proxy

The configuration of the nginx proxy is stored in the 
<walkthrough-editor-open-file filePath="nginx/default.conf.template">nginx/default.conf.template</walkthrough-editor-open-file> 
file and is **mounted** inside the nginx container. To do that, we *mount* the local folder `./nginx` inside the container at 
the path `/etc/nginx/conf.d` (See the docker-compose file to check it out).

This proxy have 2 upstreams:
- The **frontend-admin** service will be accessible trough the `/` path
- The **article-svc** service will be accessible trough the `/api` path

## The frontend

The frontend configuration is stored in the `./frontend-admin` folder. We need to update it to overwrite the default
address of the backend.

The new `apiArticlesEndpoint` value will be the result of the following line:
```bash
echo "https://${WEB_HOST}/api"
```

Mount the `./frontend-admin` configuration folder inside the container at the path `/usr/share/nginx/html/config`. 
Then start your docker compose stack.

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

## Check persistence

To check the persistence of the mongo database, you can add articles by using the frontend.
Then stop the stack and start it again: You'll see that the articles are lost.

This is because the container is **ephemeral**: The data is stored inside the container and is lost when the container is
stopped.

## Add persistence to the mongoDb container

To add persistence to the mongoDb container, you need to mount a [volume](https://docs.docker.com/compose/compose-file/compose-file-v3/#volumes)
inside the container at the path `/data/db` (like specified in the
[mongodb image documentation](https://github.com/docker-library/docs/tree/master/mongo#where-to-store-data)).
To do that, you can use a "named volume" instead a "bind mount".

Then start your docker compose stack, add articles by using the frontend, stop the stack and start it again: You'll see
that the articles are still here !

## Clean up

To delete all the resources created (including network and volumes):

```sh
docker compose down --volumes
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

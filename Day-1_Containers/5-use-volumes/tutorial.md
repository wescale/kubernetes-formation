# Exercise-5: Use docker volumes for configuration and persistence

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must login on the GCP registry:

```sh
gcloud auth login
gcloud auth configure-docker europe-west1-docker.pkg.dev
```

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
<walkthrough-editor-open-file filePath="nginx/default.conf">nginx/default.conf</walkthrough-editor-open-file> 
file and is **mounted** inside the nginx container. 

To do that, we **bind** the local folder `./nginx` inside the container at the path `/etc/nginx/conf.d` 
(See the <walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file>
file to check the syntax).

This proxy have 2 upstreams:
- The **front-admin** service will be accessible trough the `/` path
- The **article-svc** service will be accessible trough the `/api` path

## The frontend

The frontend configuration is stored in the `./front-admin` folder, in the file
<walkthrough-editor-open-file filePath="front-admin/endpoints.json">front-admin/endpoints.json</walkthrough-editor-open-file>.
We need to update it to overwrite the default address of the backend.

The new `apiArticlesEndpoint` value will be the result of the following line:
```bash
echo "https://8080-${WEB_HOST}/api/article"
```

Then, mount the `./front-admin` configuration folder inside the container at the path `/usr/share/nginx/html/config`. 

Finally, start your docker compose stack.

```bash
docker compose up -d
```

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

> Warning: As we use the same URL as preceding exercise but with a new reverse proxy, the browser cache may be very difficult to refresh. Try multiples CTRL+F5 (forced refresh) or use a private browsing tab.

## Check persistence

To check the persistence of the mongo database, you can add articles by using the frontend.
Then stop the stack by using:
```bash
docker compose down
```

Then start the stack again:
```bash
docker compose up -d
```

Then click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon to check if the articles are still here.
You'll see that all the articles are lost.

Why?

This is because the container is **ephemeral**: The data is stored inside the container and is lost when the container is
stopped.

## Add persistence to the mongoDb container

To add persistence to the mongoDb container, you need to mount a [volume](https://docs.docker.com/compose/compose-file/07-volumes/)
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

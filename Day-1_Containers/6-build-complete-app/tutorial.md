# Exercice-4: Multiple services

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will deploy the full microservices-demo application.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## Configure the application

Complete the <walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file> file.

We want to use:
- a [MongoDB](https://hub.docker.com/_/mongo/) database to store articles
  - Add a volume to handle persistence
- a [Redis](http://hub.docker.com/_/redis/) database to store the user cart content 
  - Add a volume to handle persistence
- a [cart service](https://hub.docker.com/repository/docker/alphayax/microservice-demo-cart-service) to manage the cart
  - use the `1.0` tag image
  - specify the `REDIS_URI` environment variable to connect to the redis database
- an [article service](https://hub.docker.com/repository/docker/alphayax/microservice-demo-article-service) to manage the articles
  - use the `1.0` tag image
  - specify the `MONGODB_URI` environment variable to connect to the mongo database
- a [user frontend](https://hub.docker.com/repository/docker/alphayax/microservice-demo-frontend-user) to serve the user application
  - use the `1.0` tag image
  - update the <walkthrough-editor-open-file filePath="config/frontend-user.json">frontend user config</walkthrough-editor-open-file> file.
- an [admin frontend](https://hub.docker.com/repository/docker/alphayax/microservice-demo-frontend-admin) to serve the admin application
  - use the `1.0` tag image
  - update the <walkthrough-editor-open-file filePath="config/frontend-admin.json">frontend admin config</walkthrough-editor-open-file> file.

Note that a nginx container have been set up in order to handle all the incoming connections. You don't need to modify it.

Please consult the [Docker Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) if you need help.

If you had trouble to define frontend config, you can run the `define-config.sh` script to generate the config files.


## Test the application

You can launch the following command to start all the services:

```sh
docker compose up -d
```

Open a tab to the frontend user page by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

Check that the application is working: 
- Access to the admin front by adding `/admin` to the URL
- Create some articles
- Return to the user front and add/remove some articles to the cart
- Enter the `docker compose` command to restart the containers :

```sh
docker compose restart
```
Return the application and check that the cart is still the same.

## Bonus

The data directory mounted for redis and mongodb is created with the docker engine user id...**root**.  To be cleaner, the volume would be managed by Docker, in `/var/lib/docker/volumes/`.

How can you do that?

## Clean

To delete all the resources created (including network and volumes):

```sh
docker compose down --volumes
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
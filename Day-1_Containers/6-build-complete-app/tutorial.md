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
  - update the frontend user config file.
- an [admin frontend](https://hub.docker.com/repository/docker/alphayax/microservice-demo-frontend-admin) to serve the admin application
  - use the `1.0` tag image
  - update the frontend admin config file.

In order to define the frontend configuration, you can run the following script:

```sh
./define-config.sh
```

Note that a nginx container have been set up in order to handle all the incoming connections. 
You don't need to modify it in this step.

Please consult the [Docker Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) if you need help.


## Test the application

You can launch the following command to start all the services:

```sh
docker compose up -d
```

Open a tab to the frontend user page by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

Check that the application is working by adding new articles.

Once it's done, stop your docker compose stack:
```sh
docker compose stop
```

## Swipe the frontend

Update the <walkthrough-editor-open-file filePath="config/default.conf">nginx config file</walkthrough-editor-open-file>
and update the `proxy_pass` value for the location `/` to `http://front-client/;`: The goal here is to replace the admin
frontend we use to add article by the user frontend.

Then restart the stack:
```sh
docker compose up -d
```

Once again, open a tab to the frontend user page by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> 
icon, and access the application (You can need to refresh the page).

If everything is working, you should see the articles you added previously in another interface, and you'll be able to 
add them to your cart.

You can check persistence of your cart (redis) by restarting the stack:

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

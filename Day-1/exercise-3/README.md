# exercice-3: volume up!

## Instructions

The application here is a chat based on Socket.io and NodeJS.

The chat container must mount a volume which contains an HTML page (`client` directory). This will allow us to modify the HTML page without restarting the container.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## Launch the application

Once your `docker-compose.yml` written, you can launch the following command to start all the services:
```sh
docker compose up -d
```

To test if your application works well, you can consult this page: [http://[BASTION IP]:8080](http://localhost:8080)

You can open 2 tabs and check the text you entered is duplicated on the other tab.

To control the volume is correctly mounted, edit the `client/index.html` and reload the application in your browser.

## Clean

You can stop all the containers started by docker-compose:
```sh
docker compose stop
```

Then delete all the containers:
```sh
docker compose rm
```

To delete all the resources created (including network and volumes):
```sh
docker compose down --volumes
```

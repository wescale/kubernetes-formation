# Exercice-3: Persistence with docker volumes

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

The application here is a chat based on Socket.io and NodeJS.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## Launch the application

Complete the <walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file> file.

The chat container must mount a volume which contains an HTML page (`client` directory). This will allow us to modify the HTML page without restarting the container.

You can launch the following command to start all the services:

```sh
docker compose up -d
```

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

You can open 2 tabs and check the text you entered is duplicated on the other tab.

To control the volume is correctly mounted, edit the <walkthrough-editor-open-file filePath="client/index.html">index.html</walkthrough-editor-open-file> file and reload the application in your browser.

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

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

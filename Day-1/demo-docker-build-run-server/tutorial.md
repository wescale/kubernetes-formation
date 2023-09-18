# Demo docker build and run server

<walkthrough-tutorial-duration duration="15.0"></walkthrough-tutorial-duration>

## Description

In this demo you will get familiar with the build and the run of docker images.

## Create a React app and build to get static files

Install create-react-app module:

```sh
npm i -g create-react-app
```

Create a new React application:

```sh
./create-build.sh
```

You can watch The Lord Of the Rings...

Then look at the `app-test/build` directory to show what is a React application (static, js, ...).

```sh
cd app-test
ls -la build/ && ls -la build/static/ && ls -la build/static/js/
cd -
```

## Build an image and run the container

Look at the `./DockerFile``. ; **Explain it.**

Then build:

```sh
./run-container.sh
```

## Test

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon. Open, port 3000

## Clean

```sh
./run-rm.sh
```

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

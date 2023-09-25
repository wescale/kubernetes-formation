# Demo docker build and run server

<walkthrough-tutorial-duration duration="15.0"></walkthrough-tutorial-duration>

## Description

In this demo you will get familiar with the build and the run of docker images.

## See the existing application

The Python Flask application is very simple. See the only code file: <walkthrough-editor-open-file filePath="python-code/app.py">python-code/app.py</walkthrough-editor-open-file>.

To manage the dependencies, see the <walkthrough-editor-open-file filePath="python-code/requirements.txt">python-code/requirements.txt</walkthrough-editor-open-file> file.

## Build an image and run the container

Look at the <walkthrough-editor-open-file filePath="Dockerfile">Dockerfile</walkthrough-editor-open-file>.

**Explain it.**

Then build an image and start a container from this image:

```sh
./run-container.sh
```

## Test

To test if your application works well, you can click on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon. Open, port 8080

## Clean

```sh
./run-rm.sh
```

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

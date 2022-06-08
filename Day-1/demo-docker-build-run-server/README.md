# Demo first build

## Create a React app and build to get static files 

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

You can connect on port 3000.

**N.B: if you use a web browser, HSTS can automatically redirects to HTTPS which will fail. Use IP for that.**

```sh
curl http://PUBLIC_IP:3000/
```


## Clean

```sh
./run-rm.sh
```

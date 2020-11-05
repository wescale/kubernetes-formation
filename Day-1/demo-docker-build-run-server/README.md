# Demo first build

## Create a REACT app and build to get static files 

```sh
./create-build.sh
```

You get watch The Lord Of the Rings...

Then look at the `app-test/build` directory.

## Build an image and run the container

Look at the `./DockerFile``. ; **Explain it.**

Then build:

```sh
./run-container.sh
```

## Test

You can connect on port 5000
```sh
curl http://PUBLIC_IP:5000/
```

## Clean

```sh
./run-rm.sh
```

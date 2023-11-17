# Demo service discovery with Traefik

<walkthrough-tutorial-duration duration="30.0"></walkthrough-tutorial-duration>

## Description

You will use traefik to illustrate service discovery:

* Load balancing between pool members
* Fixed endpoint exposure with transparent routing
* Dynamic insertion/removal of pool members
* Continuous monitoring to remove unhealthy containers

## Launch traefik

Inspect the  <walkthrough-editor-open-file filePath="./traefik/docker-compose.yml">docker compose file for traefik</walkthrough-editor-open-file>.

In particular, the mount of `/var/run/docker.sock` and the `--docker` option.

Then, launch this stack:

```sh
cd traefik
docker compose up -d
cd -
```

Open the traefik admin page on port 8080 by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

Inspect the current HTTP routers and services.

## Launch the application

It relies on 2 components:

* A webservice (directory `webservice-test`). If you look at the <walkthrough-editor-open-file filePath="./webservice-test/Dockerfile">Dockerfile</walkthrough-editor-open-file>, does it seem special?
* A front Single Page App (directory `front-test`)

Build the Single Page App for `front-test`:

```sh
cd front-test
npm install
npm run build
cd -
```

Then, you can start the application:

```sh
cd infra
docker compose up -d
```

Observe the <walkthrough-editor-open-file filePath="./infra/docker-compose.yml">infra/docker-compose.yml file,</walkthrough-editor-open-file> especially the labels.

Now, if you consult the Traefik HTTP services, you should see two more entries: **front-infra** and **webservice-infra**.

What are the routing rules for those services?

What are the containers IP behind those services?

## Scale some services

```sh
docker compose up --scale webservice=2 -d
```

You should see the additional containers in the Traefik admin UI.

## Mark a container down

If you looked at the <walkthrough-editor-open-file filePath="./webservice-test/health.go">./webservice-test/health.go code</walkthrough-editor-open-file>, you will see a hack to return the HTTP error 500 if the file `/tmp/health_KO` exists inside a webservice container.

Thus, you can mark a webservice container as unhealthy:

```sh
docker exec -ti infra-webservice-1 touch /tmp/health_KO
```

Wait 10 secondes and see the status of the webservice containers:

```sh
docker ps -a
```

What happened in Traefik ?

## Clean

```sh
cd ..
./terminate-infra.sh
```

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

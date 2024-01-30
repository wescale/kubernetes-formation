# Demo service discovery with Traefik

<walkthrough-tutorial-duration duration="30.0"></walkthrough-tutorial-duration>

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

You will use traefik to illustrate service discovery:
* Load balancing between pool members
* Fixed endpoint exposure with transparent routing
* Dynamic insertion/removal of pool members
* Continuous monitoring to remove unhealthy containers

## Launch traefik

Inspect the <walkthrough-editor-open-file filePath="./traefik/docker-compose.yml">docker-compose file for traefik</walkthrough-editor-open-file>.

In particular, the mount of `/var/run/docker.sock` and the `--docker` option.

Then, launch this stack:
```sh
docker compose \
  --project-directory traefik \
  up -d
```

Open the traefik admin page on port 8080 by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

Inspect the current HTTP routers and services.

## Launch the application

We'll use the same application as in the previous exercise.

Start the application:

```sh
docker compose \
  --project-directory infra \
  up -d
```

Observe the <walkthrough-editor-open-file filePath="./infra/docker-compose.yml">infra/docker-compose.yml</walkthrough-editor-open-file> file, especially the [labels](https://doc.traefik.io/traefik/v1.4/configuration/backends/docker/#on-containers).

Now, if you consult the Traefik HTTP services, you should see 7 more entries: 
- `api-article-infra`
- `api-cart-infra`
- `front-admin-infra`
- `front-user-infra`
- `test-infra`

What are the routing rules for those services?

What are the containers IP behind those services?

## Scale some services

```sh
docker compose \
  --project-directory infra \
  up \
  --scale test=4 \
  -d
```

You should see the additional containers in the Traefik admin UI.

## Mark a container down

If you looked at the <walkthrough-editor-open-file filePath="./webservice-test/health.go">./webservice-test/health.go code</walkthrough-editor-open-file>, you will 
see a hack to return the HTTP error 500 if the file `/tmp/health_KO` exists inside a webservice container.

Thus, you can mark a webservice container as unhealthy:

```sh
docker exec -ti infra-test-1 touch /tmp/health_KO
```

Wait 10 seconds and see the status of the webservice containers:

```sh
docker ps -a | grep infra-test
```

What happened in Traefik ?

## Clean

```sh
./infra-terminate.sh
```

## Congratulations

You have finished this demonstration!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

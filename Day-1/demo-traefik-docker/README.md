# demo traefik and docker

You will use traefik to show what a service discovery does.

## Steps

### Launch traefik

```sh
cd traefik

docker-compose up -d
cd -
```

To access the traefik admin page, go to [http://[BASTION IP]:8080](http://localhost:8080).
Inspect the current HTTP routers and services.

### Launch the application

It relies on 2 components:
* a webservice (directory `webservice-test`). If you look at the Dockerfile, does it seem special?
* a front Single Page App (direcotry `front-test`)

```sh
# Build the SinglePageApp
cd ../front-test
npm install
npm run build

cd ../infra
# Start the application
docker-compose up -d
```

Now, if you consult the Traefik HTTP services[http://BASTION_IP:8080/dashboard/#/http/services](http://BASTION_IP:8080/dashboard/#/http/services), you should see two more entries: **front-infra** and **webservice-infra**.

What are the routing rules for those services?
What are the containers IP behind those services?

### Test

If you want to test the application, edit your /etc/hosts file:

```sh
X.X.X.X front-infra webservice-infra
```

Then open a browser on [http://front-infra:8000](http://front-infra:8000)

### Scale some services

```sh
docker-compose up --scale webservice=2 -d
```

You should see the additional containers in the Traefik admin UI.

### Mark a container down

On the bastion, mark a webservice unavaiable:
```sh
docker exec -ti XXXXX touch /tmp/health_KO
```

Wait 10 secondes and see the status of the webservice containers:
```sh
docker ps -a
```

What happened in Traefik ?
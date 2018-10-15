#!/bin/bash

cd traefik

docker-compose up -d

cd ../infra

docker-compose up -d

docker-compose scale webservice=10

cd ..

curl -H Host:webservice.docker.localhost http://localhost/ips

curl -H Host:webservice.docker.localhost -X POST -d '{ "path": "/tmp/health_KO" }' http://localhost/hack/file

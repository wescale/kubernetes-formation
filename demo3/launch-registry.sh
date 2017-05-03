#!/bin/bash

eval $(docker-machine env -u)
docker-machine create \
      --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
      --driver virtualbox \
      registry-vm

eval $(docker-machine env registry-vm)
docker run -d -p 5000:5000 --name registry registry:2
eval $(docker-machine env -u)

ip_registry=$(docker-machine ip registry-vm)
docker tag front-app:v1 $ip_registry:5000/front-app:v1
docker tag webservice-app:v1 $ip_registry:5000/webservice-app:v1

docker push $ip_registry:5000/front-app:v1
docker push $ip_registry:5000/webservice-app:v1

minikube start --insecure-registry=$(docker-machine ip registry-vm):5000
minikube dashboard
minikube addons enable heapster


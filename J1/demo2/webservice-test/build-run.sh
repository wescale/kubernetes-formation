#!/bin/bash

docker rm -f ws-inst
docker build -t webservice-app:v1 .
docker run --name ws-inst -p 8080:8080 -d webservice-app:v1


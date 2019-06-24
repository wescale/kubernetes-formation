#!/bin/bash

docker rm -f front-inst
npm install
npm run build
docker build -t front-app:v1 .
docker run --name front-inst -p 3000:3000 -d front-app:v1
# docker run --name front-inst --link ws-inst -p 5000:5000 -d front-app:v1


#!/bin/bash

cp Dockerfile app-test/
cd app-test

npm run build

docker build -t app-nginx:v1 .
docker run --name some-nginx -p 8080:80 -d app-nginx:v1


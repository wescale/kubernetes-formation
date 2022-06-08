#!/bin/bash

set -e

cp Dockerfile app-test/
cd app-test

docker build -t app-test:v1 .
docker run --name app-test-inst -p 3000:3000 -it app-test:v1


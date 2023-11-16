#!/bin/bash

set -e

docker build -t app-test:v1 .
docker run --name app-test-inst -p 8080:5000 -it app-test:v1


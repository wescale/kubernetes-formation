#!/bin/bash

cd traefik

docker compose up -d

cd ../front-test
npm install
npm run build

cd ../infra

docker compose up -d

docker compose scale webservice=2

cd ..

echo -e "Add your public bastion IP to /etc/hosts:"
echo -e "X.X.X.X front-infra webservice-infra\n"
echo -e "You can run the following command to mark a container unhealthy:"
echo -e "curl -H Host:webservice-infra -X POST -d '{ \"path\": \"/tmp/health_KO\" }' http://localhost/hack/file"
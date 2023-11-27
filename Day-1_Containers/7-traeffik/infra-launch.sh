#!/bin/bash

echo "> Start traefik"
docker compose --project-directory traefik up -d

echo "> Start infra"
docker compose --project-directory infra up -d

echo "> Scale up test to 4"
docker compose --project-directory infra up --scale test=4 -d

cat <<EOL

You can run the following command to mark a container unhealthy:
docker exec -ti infra-test-1 touch /tmp/health_KO
EOL

#!/bin/bash

docker compose --project-directory infra down
docker compose --project-directory traefik down

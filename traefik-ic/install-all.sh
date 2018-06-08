#!/bin/bash
for i in `seq 1 10`;
do
        gcloud container clusters get-credentials "training-cluster-$i" --zone europe-west1-b
        kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=sebastien.lavayssiere@wescale.fr
        kubectl apply -f traefik-rbac.yaml
        kubectl apply -f traefik-ds.yaml
done

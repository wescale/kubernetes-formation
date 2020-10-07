#!/bin/bash

set -euo pipefail

username=$(gcloud config get-value account)

for i in `seq 1 5`;
do
        gcloud container clusters get-credentials "training-cluster-0" --zone europe-west1-b --project "wsc-kubernetes-training-$i"
        #gcloud container clusters get-credentials "training-cluster-$i" --zone europe-west1-b
        kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$username
        kubectl apply -f traefik-rbac.yaml
        kubectl apply -f traefik-ds.yaml
        kubectl apply -f ../../J3/exercice-monitoring/rbac.yaml
done

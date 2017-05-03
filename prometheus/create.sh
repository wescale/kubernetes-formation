#!/bin/bash

kubectl create -f prometheus.yml
kubectl get pods -l app=prometheus -o name |     sed 's/^.*\///' |     xargs -I{} kubectl port-forward {} 9090:9090


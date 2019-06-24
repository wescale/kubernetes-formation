# OBJECTIF: Effectuer un Rolling Update
## Déployer V1.0
kubectl apply -f Strategies_deploiement/deployment-v1.0.yaml

## Vérifier que tout c'est bien passé
kubectl get deployments
kubectl describe deployments kdemo-dep
kubectl get pods -o wide


## Creation d'un service avec un External Endpoint 

kubectl expose deployment kdemo-dep \
--type=LoadBalancer \
--name=kdemo-svc \
--port=80 \
--target-port=8080

ou 

kubectl create -f Strategies_deploiement/service.yaml

## Retrouver l'IP Externe

kubectl get services kdemo-svc

## Afficher  le site sur un Browser

## Déployer une nouvelle version du site
kubectl apply -f Strategies_deploiement/deployment-v1.1.yaml

## Vérifier l'etat des pods
kubectl get pods -o wide

## Roll Back le déploiement
kubectl rollout undo deployment kdemo-dep

kubectl rollout status deployment kdemo-dep

## VCleaning

## Suppression du service 
kubectl delete services kdemo-svc

##  Suppression du deployment
kubectl delete -f Strategies_deploiement/deployment-v1.1.yaml
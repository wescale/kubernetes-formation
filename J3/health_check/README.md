## Healthcheck Demo Workflow
Nous explorons la haute disponibilité d'un déploiement kubnernetes avec un Readiness/Liveness


### Executer le déploiement du service / healthy déployment  
```
kubectl apply -f service.yaml
kubectl apply -f healthy-deployment.yaml
```
### Affichage des pods
```
kubectl get pods -o wide
```
### Affichage du Site 
```
kubectl get services
```
### Utilisé le déploiement qui est en echec
```
kubectl apply -f broken-deployment.yaml
```

### Qu'est ce qui s'affit en warning ?
```
kubectl get event
```
### Raffraichis la webapp 
Toujours "version 1.0 qui s'affiche" 

### Nettoyage

Suppression du service et déploiement
```
kubectl delete -f service.yaml
kubectl delete -f broken-deployment.yaml
```
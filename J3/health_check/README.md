## Healthcheck Demo Workflow
Nous explorons la haute disponibilité d'un déploiement kubnernetes avec les sondes Readiness/Liveness


### Executez le déploiement du service / healthy déployment  
```
kubectl apply -f service.yaml
kubectl apply -f healthy-deployment.yaml
```
### Affichez des pods
```
kubectl get pods -o wide
```
### Affichez le Site 

Retrouvez les informations de connexions :
```
kubectl get services
```

Puis faites un curl.

### Utilisez le déploiement qui est en echec
```
kubectl apply -f broken-deployment.yaml
```

### Qu'est ce qui s'affiche en warning ?
```
kubectl get events --sort-by=.metadata.creationTimestamp --field-selector type!=Normal
```
### Raffraichissez la webapp 
Toujours "version 1.0 qui s'affiche" 

### Nettoyage

Suppression du service et déploiement
```
kubectl delete -f service.yaml
kubectl delete -f broken-deployment.yaml
```
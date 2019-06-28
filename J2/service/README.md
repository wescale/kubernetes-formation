1. Création d'un service CLUSTERIP
2. Création d'un service NodePort
3. Création d'un service LoadBalancer
4. Néttoyage de l'ensemble: 
```
   kubectl delete services my-cip-service my-np-service my-lb-service
   kubectl delete deployments my-deployment my-deployment-50000 my-deployment-50001
```

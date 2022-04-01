# exercise-5: services

You will explore the different types of services proposed by kubernetes:

1. Create a CLUSTER IP service
2. Create NodePort service
3. Create a LoadBalancer service
4. Clean the resources:
```sh
kubectl delete services my-cip-service my-np-service my-lb-service
kubectl delete deployments my-deployment my-deployment-50000 my-deployment-50001
```

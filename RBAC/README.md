##

Create a service account:
```
kubectl create serviceaccount myapp
```

Create a pod associated to service account myapp:
```
kubectl create -f pod-sa.yaml
````

Create a config map:
```
kubectl create configmap myconfig --from-literal data_1=foo
````

Get inside the pod and  execute  :
```
kubectl exec -it pod-sa -- /bin/bash
# then display the configmap
kubectl get configmap myconfig
```
Can you explain what happened ?


Create a Role:
```
kubectl create -f role.yaml
```

Create a RoleBinding:
```
kubectl create -f binding.yaml
```

Try again to display the configMap inside the pod

Then try to change the configmap

Can you explain what happened ?
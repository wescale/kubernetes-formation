# Création d'un namespace

```
kubectl create namespace resource-constraints-demo
```

# Création des LimiteRange

```
apiVersion: v1
kind: LimitRange
metadata:
  name: resource-constraints-lr
spec:
  limits:
  - max:
      memory: 1Gi
      cpu: 0.8
    min:
      memory: 500Mi
      cpu: 0.3
    type: Container
```
```
kubectl create -f resource-constraints-pod.yaml --namespace resource-constraints-demo
```

```
kubectl get pod resource-constraints-pod --namespace resource-constraints-demo --output=yaml
```

Qu'est ce que vous remarquez ?

```
kubectl create -f resource-constraints-pod-2.yaml --namespace resource-constraints-demo
```

Qu'est ce que vous remarquez ?

# Creation d'un ResourceQuotas

```
kubectl create namespace resource-quota-demo
```

```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: resource-quota
spec:
  hard:
    requests.cpu: "1.4"
    requests.memory: 2Gi
    limits.cpu: "2"
    limits.memory: 3Gi
```
```
kubectl create -f resource-quota.yaml --namespace resource-quota-demo
```
```
kubectl get resourcequota --namespace resource-quota-demo --output=yaml
```


```
kubectl create -f resource-quota-pod-1.yaml --namespace resource-quota-demo
```

```
kubectl get resourcequota --namespace resource-quota-demo --output=yaml
``` 


```
kubectl create -f resource-quota-pod-2.yaml --namespace resource-quota-demo
```

Qu'est ce que vous remarquez ?

# Nettoyage
```
kubectl delete namespace resource-constraints-demo
kubectl delete namespace resource-quota-demo
```




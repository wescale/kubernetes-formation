# Création d'un namespace

```
kubectl create namespace default-resources-config
```

# Création des limites cpu et memoire par défaut

```
apiVersion: v1
kind: LimitRange
metadata:
  name: default-requests-and-limits
spec:
  limits:
  - default:
      memory: 512Mi
      cpu: 0.8
    defaultRequest:
      memory: 256Mi
      cpu: 0.4
    type: Container
```
```
kubectl create -f limit-range-1.yaml --namespace=default-resources-config
```


# Création d'un POD

```
apiVersion: v1
kind: Pod
metadata:
  name: default-resources-demo
spec:
  containers:
  - name: default-resources-cont
    image: httpd:2.4
```
```
kubectl create -f default-resources-demo-pod.yaml --namespace default-resources-config
```
# Consultation de l'outpu du POD

```
kubectl get pod default-resources-demo --output=yaml --namespace=default-resources-config
```
=> Qu'est ce que vous remarquez ?

Et si vous spécifiez uniquement les limits  ? 

```
kubectl create -f default-resources-demo-pod-2.yaml --namespace default-resources-config
```
```
kubectl get pod default-resources-demo-2 --output=yaml --namespace default-resources-config
```

Qu'est ce que vous remarquez ?


Et si vous spécifiez uniquement les requests ?

```
kubectl create -f default-resources-demo-pod-3.yaml --namespace default-resources-config
```

```
kubectl get pod default-resources-demo-3 --output=yaml --namespace default-resources-config
```

Qu'est ce que vous remarquez ?

# Nettoyage
```
kubectl delete namespace default-resources-config
```



 

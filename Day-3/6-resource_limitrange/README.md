# exercise-6: Default limits and request with a LimitRange

In this exercise, you will create a new namespace and set LimitRange for this namespace.

Then, you will create 3 pods, each with or without requests and limits.

## Create a namespace

```sh
kubectl create namespace default-resources-config
```

## Create a LimitRange to specifiy default limits and requests

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

```sh
kubectl create -f limit-range-1.yaml --namespace=default-resources-config
```

## Create a Pod without resource specifications

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

```sh
kubectl create -f default-resources-demo-pod.yaml --namespace default-resources-config
```

The Pod should be a `best effort`.

Check its QoS class and resource requests/limits:
```sh
kubectl get pod default-resources-demo --output=yaml --namespace=default-resources-config
```

Are the values the ones we expected?

## Create a Pod with only limits

```sh
kubectl create -f default-resources-demo-pod-2.yaml --namespace default-resources-config
```

```sh
kubectl get pod default-resources-demo-2 --output=yaml --namespace default-resources-config
```

What do you see as QoS class?

Why?

## Create a Pod with only requests

```
kubectl create -f default-resources-demo-pod-3.yaml --namespace default-resources-config
```

```
kubectl get pod default-resources-demo-3 --output=yaml --namespace default-resources-config
```

What do you see as QoS class?

Why?

## Clean
```
kubectl delete namespace default-resources-config
```



 

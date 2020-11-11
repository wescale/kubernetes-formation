# exercise-7: Limits per container and inside a namespace

In this exercise, you will see how to control the maximum resource used in a namspace:
* LimitRange to defing limits per container
* ResourceQuota to define limits inside the whole namespace

## Start by creating a namespace
```sh
kubectl create namespace resource-constraints-demo
```

## Create a LimitRange to bound the min/max limits

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

```sh
kubectl create -f limit-range-2.yaml --namespace=resource-constraints-demo
```

## Create a pod matching the LimitRange
```sh
kubectl create -f resource-constraints-pod.yaml --namespace resource-constraints-demo
```

Get the QoS class and resource requests/limits:
```sh
kubectl get pod resource-constraints-pod --namespace resource-constraints-demo --output=yaml
```

Are the values matching the ones we expected?

## Create pod outside the boudaries of the LimitRange
```sh
kubectl create -f resource-constraints-pod-2.yaml --namespace resource-constraints-demo
```

## Creata a new namespace 

```sh
kubectl create namespace resource-quota-demo
```

## Create a ResourceQuota
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

```sh
kubectl create -f resource-quota.yaml --namespace resource-quota-demo
```

Get the current ResourceQuota usage:
```sh
kubectl get resourcequota --namespace resource-quota-demo --output=yaml
```

## Create a first pod inside the namespace with resource quota

```
kubectl create -f resource-quota-pod-1.yaml --namespace resource-quota-demo
```

## Create a second pod inside the namespace with resource quota
```
kubectl create -f resource-quota-pod-2.yaml --namespace resource-quota-demo
```

What happens?

## Clean
```
kubectl delete namespace resource-constraints-demo
kubectl delete namespace resource-quota-demo
```
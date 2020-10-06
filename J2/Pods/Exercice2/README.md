## Description
In this hands-on lab, you will be presented with a three worker node.
You will be responsible for splitting up the three worker nodes and making:
* one of the worker nodes a production (prod) environment node.
* one of the worker nodes a development (dev) environment node.
* one of the worker nodes a pre-production (iso) environment node.


The purpose of identifying the production type is to not accidentally deploy pods into the production environment. You will use taints and tolerations to achieve this, and then you will deploy two pods: One pod will be scheduled to the dev environment, and one pod will be scheduled to the prod environment.

## Taint one of the worker nodes to repel work.

# Get list nodes with current taints
```
kubectl get nodes  -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```
```
# Deploy a pod which does not tolerate taints
kubectl apply -f no-toleration-pod.yml
```

Ensure the pod is running.

# For each node, apply a taint
```
kubectl taint node NODE-1 node-type=dev:NoExecute
kubectl taint node NODE-2 node-type=iso:NoExecute
kubectl taint node NODE-3 node-type=prod:NoExecute
```

# Verify the taints are ok
```
kubectl taint node <node_name> node-type=prod:NoSchedule
```

Is the no-toleration-pod still running ? Why?

## Schedule a pod to the dev environment.

# Create a yaml file containing the pod spec and a DEV Taint Tolerance
```
apiVersion: v1
kind: Pod
metadata:
 name: dev-pod
 labels:
   app: busybox
spec:
 containers:
 - name: dev
   image: busybox
   command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']
 tolerations:
 - key: node-type
   operator: Equal
   value: dev
   effect: NoExecute
```

# Create the pod
```
kubectl create -f dev-pod-busybox.yml
```
# Verify
```
kubectl get pod -o wide
```

On which node is it running ? Why ?

## Allow a pod to be scheduled to the prod environment.
# Create a yaml file containing the pod spec and a Production Taint Tolerance
```
apiVersion: v1
kind: Pod
metadata:
 name: prod-pod
 labels:
   app: busybox
spec:
 containers:
 - name: prod
   image: busybox
   args:
    - sleep
    - "3600"
   command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']
 tolerations:
    - key: node-type
       operator: Equal
       value: prod
       effect: NoSchedule
```

## Create a yaml file containing the pod spec
```
kubectl create -f prod-deployment.yml
```
## Verify each pod has been scheduled and verify the toleration.
```
kubectl get pods -o wide
```

Is the prod pod running ? Why ?

## Remove Taint
```
kubectl taint nodes <node_name> node-type-
```
# exercise-2: Taints and tolerations

In this hands-on lab, you will get familiar with taints and tolerations.

On your multi worker cluster, you will deploy a pod which does not tolerate taints.
Then, you will add taints to all the workers and see the effect.

You will be responsible for splitting up the worker nodes and making:
* one of the worker nodes a production (prod) environment node.
* one of the worker nodes a development (dev) environment node.
* ONLY if you have a threee workder node cluster: one of the worker nodes a pre-production (iso) environment node.

The purpose of identifying the production type is to not accidentally deploy pods into the production environment. You will use taints and tolerations to achieve this, and then you will deploy two pods: One pod will be scheduled to the dev environment, and one pod will be scheduled to the prod environment.

## Deploy a pod which does not tolerate taints

Get list nodes with current taints:
```sh
kubectl get nodes  -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

Deploy a pod which does not tolerate taints (be carefull, the provided `.yaml` file may be incorrect....)
```sh
kubectl apply -f no-toleration-pod.yml
```

Ensure the pod is running and note the worker it is running on.

## For each worker node, apply a taint

*DO not add taint to a MASTER node!*:
```
kubectl taint node <NODE1_NAME> node-type=prod:NoExecute
kubectl taint node <NODE2_NAME> node-type=dev:NoExecute
```

If your cluster has 3 worker nodes:
```sh
kubectl taint node <NODE3_NAME> node-type=iso:NoExecute
```

## Verify the taints are ok

```sh
kubectl get nodes  -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

Is the no-toleration-pod still running ? Why?

## Schedule a pod to the dev environment.

Here is the pod spec:
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

Create the pod:
```sh
kubectl create -f dev-pod-busybox.yml
```

Verify it is running:
```sh
kubectl get pod -o wide
```

On which node is it running ? Why ?

## Allow a pod to be scheduled to the prod environment.

Create a yaml file containing the pod spec and a Production Taint Tolerance:
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

Create a yaml file containing the pod spec:
```sh
kubectl create -f prod-deployment.yml
```

Verify each pod has been scheduled and verify the tolerations.
```
kubectl get pods -o wide
```

Is the prod pod running ? Why ?

## Clean

Remove Taint on all the worker nodes.
For that, use the `taint node` subcommand and add *-*- at the end of the taint name:
```
kubectl taint node <NODE1_NAME> node-type-
kubectl taint node <NODE2_NAME> node-type-
```

If your cluster has 3 worker nodes:
```sh
kubectl taint node <NODE3_NAME> node-type-
```

Delete all the created pods:
```sh
kubectl delete -f .
```

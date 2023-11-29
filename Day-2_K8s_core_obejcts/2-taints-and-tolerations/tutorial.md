# Exercise 2.2 - Taints and tolerations

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this hands-on lab, you will get familiar with taints and tolerations.

On your multi worker cluster, you will deploy a pod which does not tolerate taints.

Then, you will add taints to all the workers and see their effect.

You will be responsible for splitting up the worker nodes and making:
* one of the worker nodes a production (`prod`) environment node.
* one of the worker nodes a development (`dev`) environment node.
* one of the worker nodes a pre-production (`iso`) environment node.

The purpose of identifying the production type is to not accidentally deploy pods into the production environment. You 
will use taints and tolerations to achieve this, and then you will deploy two pods: One pod will be scheduled to the **dev** 
environment, and one pod will be scheduled to the **prod** environment.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer: <walkthrough-project-setup></walkthrough-project-setup>

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy a pod which does not tolerate taints

Get the list of nodes with current taints:

```sh
kubectl get nodes \
  -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

Edit the <walkthrough-editor-open-file filePath="no-toleration.pod.yml">no-toleration.pod.yml</walkthrough-editor-open-file> 
to get a pod which does not tolerate taints. Be carefully, the provided file may be incorrect...

```sh
kubectl apply -f no-toleration.pod.yml
```

Ensure the pod is running and note the worker it is running on.

## For each worker node, apply a taint

**DO not add taint to a Master nodes!**:

```sh
kubectl taint node <NODE1_NAME> node-type=prod:NoExecute
kubectl taint node <NODE2_NAME> node-type=dev:NoExecute
kubectl taint node <NODE3_NAME> node-type=iso:NoExecute
```

## Verify the taints are ok

```sh
kubectl get nodes \
  -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints
```

**Question**: Is the `no-toleration-pod` still running ? Why?

## Schedule a pod to the dev environment

Complete the given <walkthrough-editor-open-file filePath="dev-mongo.pod.yml">dev-mongo.pod.yml</walkthrough-editor-open-file> 
file to tolerate the taint `node-type` with value `dev` and effect `NoExecute`.

Create the pod:
```sh
kubectl create -f dev-mongo.pod.yml
```

Verify it is running:
```sh
kubectl get pod -o wide
```

**Question**: On which node is it running ? Why ?

## Allow a pod to be scheduled on the prod environment

Create a yaml file named `prod-mongo.pod.yml` which contains the following pod spec:

```yaml
apiVersion: v1
kind: Pod
metadata:
 name: prod-pod
 labels:
   app: mongo

spec:

  containers:
    - name: prod
      image: "mongo:7"

  tolerations:
    - key: node-type
      operator: Equal
      value: prod
      effect: NoSchedule
```

Create a yaml file containing the pod spec:
```sh
kubectl create -f prod-mongo.pod.yml
```

Verify each pod has been scheduled and verify the tolerations:
```sh
kubectl get pods -o wide
```

**Question**: Is the prod pod running ? Why ?

## Clean

### Remove Taint on all the worker nodes

For that, use the `taint node` subcommand and add `-` at the end of the taint name:

```sh
kubectl taint node <NODE1_NAME> node-type-
kubectl taint node <NODE2_NAME> node-type-
kubectl taint node <NODE3_NAME> node-type-
```

Or more simply:
```sh
kubectl taint node node-type- --all
```

### Delete all the created pods

```sh
kubectl delete -f .
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

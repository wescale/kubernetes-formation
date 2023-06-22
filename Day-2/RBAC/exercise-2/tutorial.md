# RBAC

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a configmap and try to get the config map from a pod, using a service account.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Create a pod using a service account

Until now, you have used the default service account from the current namespace.

Create a new service account named `myapp`:

```sh
kubectl create serviceaccount myapp
```

Modify the <walkthrough-editor-open-file filePath="pod-sa.yaml">pod-sa.yaml</walkthrough-editor-open-file> file to have the pod using the `myapp` service account.

Then create the pod:

```sh
kubectl create -f pod-sa.yaml
```

## Create a configmap and try to access it from the pod

Create a config map:

```sh
kubectl create configmap myconfig --from-literal data_1=foo
```

Go inside the pod and access the config map:

```sh
kubectl exec -it pod-sa -- bash
# then display the configmap
kubectl get configmap myconfig
```

Can you explain what happened ?

## Create a Role and a RoleBinding for the service account

Complete the <walkthrough-editor-open-file filePath="role.yaml">role.yaml</walkthrough-editor-open-file> file to allow read access to configmaps:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: configmap-reader
rules:
- apiGroups: [""] 
  # Complete the file
  ...
```

Then create the role.

See the <walkthrough-editor-open-file filePath="binding.yaml">binding.yaml</walkthrough-editor-open-file> file to create a RoleBinding between the role `configmap-reader` to the service account `myapp`.

Create the role binding:

```sh
kubectl create -f binding.yaml
```

Retry to display the configMap from the pod

Then try to change the configmap

Can you explain what happened ?

## Clean

Exit the shell inside in the pod and run:

```sh
kubectl delete -f pod-sa.yaml
kubectl delete -f binding.yaml
kubectl delete -f role.yaml
kubectl delete cm/myconfig
kubectl delete sa/myapp
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

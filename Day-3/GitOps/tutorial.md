# Gitops with ArgoCD

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will instanciate an ArgoCD and get familiar with basics of GitOps

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Install ArgoCD

You will work inside the `argocd` namespace. Remember to add the `-n argocd` option to every command.

Create the `argocd` namespace.

Then deploy ArgoCD:

```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Connect to the ArgoCD server

Get the password of the `admin` user:

```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Then edit the service `argocd-server` to change its type to NodePort.

Note the allocated port.

Open a browser on <PUBLIC_NODE_IP>:<ALLOCATED_PORT>, then login.

## Create you first application

Inside the default project, create a new application named `ui-gitops-chart`:

* Enable `Auto create namespace`.
* For the repository, indicate: `https://github.com/wescale/k8s-advanced-training.git`
* Path: `Correction/Helm/exercice 2/sample-demo`
* Destination: the default cluster
* namespace: `ui-gitops`

Then click on **Create**.

You should see your application.

**Sync** it and verify it has been correctly configured.

## Declarative manifests

Look at the resources your kubernetes cluster can manage:

```sh
kubectl api-resources
```

What are the resources provided by **argo**?

Edit the given <walkthrough-editor-open-file filePath="application.yaml">application.yaml</walkthrough-editor-open-file> to declare an ArgoCD application named `declarative-gitops-chart`.

This application must deploy the same Helm chart as above.

This chart must be in the namespace `declarative-gitops`.

Then apply the manifest:

```sh
kubectl apply -f application.yaml
```

Look at the ArgoCD UI to view the state of your deployment.

## Clean

Note the deletion of namespace will delete every resources inside.

This can be dangerous on production :-)

```sh
kubectl delete ns argocd
kubectl delete ns ui-gitops
kubectl delete ns declarative-gitops
kubectl delete ns declarative-gitops
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

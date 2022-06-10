In this exercise, you will instanciate an ArgoCD and get familiar with basics of GitOps.


## Install ArgoCD

Create an `argocd` namespace.

Then deploy ArgoCD:
```sh
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Connect on the ArgoCD server

Get the password of the `admin` user:
```sh
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
```

Then run port-forward to reach the service of `argocd server` on local port 8080. Something like `kubectl port-forward -n argocd svc/SERVICE_NAME LOCALPORT:SERVICE_PORT`

Open a browser on localhost:8080, then login.

What is the default cluster URL?

# Create you first application

Inside the default project, create a new application named `ui-gitops-chart`.
* Enable `Auto create namespace`.
* For the repository, indicate: `https://github.com/wescale/k8s-advanced-training.git`
* Path: `Correction/Helm/exercice 2/sample-demo`
* Destination: the default cluster
* namespace: `ui-gitops`

Then click on **Create**.

You should see your application.

**Sync** it and verify it has been correctly configured.

# Declarative manifests

Look at the resources your kubernetes cluster can manage (`kubectl api-resources`).
What are the resources provided by **argo**?

Edit the given `application.yaml` to declare an ArgoCD application named `declarative-gitops-chart` to deploy the same Helm chart as above.

This chart must be in the namespace `declarative-gitops`.

Then apply the manifest: `kubectl apply -f application.yaml`

Look at the ArgoCD UI to view the state of your deployment.
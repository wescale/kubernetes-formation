# Rolling-update

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will deploy a version *v1* of your application.

After performing a rolling update to the version *v1.1*, you will do a rollback to *v1*.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy the version v1

Complete the provided <walkthrough-editor-open-file filePath="deployment-v1.0.yaml">deployment-v1.0.yaml</walkthrough-editor-open-file> file to indicate the deployment strategy:

```yaml
strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```

Then create the deployment:

```sh
kubectl apply -f deployment-v1.0.yaml
```

## Ensure everything is fine

List the deployements, get details about `kdemo-dep` and consult the pod statuses:

```sh
kubectl get deployments
kubectl describe deployments kdemo-dep
kubectl get pods -o wide
```

## Create a service to externally expose the deployment

What are the solutions to expose a service outside the cluster network ?

Here, we create a NodePort service imperatively:

```sh
kubectl expose deployment kdemo-dep \
--type=NodePort \
--name=kdemo-svc \
--port=80 \
--target-port=8080
```

or declaratively with a  <walkthrough-editor-open-file filePath="service.yaml">service.yaml</walkthrough-editor-open-file> file:

```sh
kubectl apply -f service.yaml
```

Retrieve the external IP/port.

Then display the service in your web Browser.

## Deploy a new version of the site

See <walkthrough-editor-open-file filePath="deployment-v1.1.yaml">deployment-v1.1.yaml</walkthrough-editor-open-file> file, which updates the image tag.

Then apply the update:

```sh
kubectl apply -f deployment-v1.1.yaml
```

Check the pod statuses:

```sh
watch kubectl get pods -o wide
```

Verify you get a new version of the website in your browser.

## RollBack to v1.0

Kubernetes allows to perform rollback of deployment with the `rollout` command.

Perform a rollback for deployment `kdemo-dep` and consult its status:

```sh
kubectl rollout undo deployment kdemo-dep

kubectl rollout status deployment kdemo-dep
```

## Clean

```sh
kubectl delete services kdemo-svc
kubectl delete -f deployment-v1.1.yaml
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

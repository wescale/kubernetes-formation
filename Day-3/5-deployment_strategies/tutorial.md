# Rolling-update

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will deploy a subset of your application (MongoDB + article-service) in the version *0.0.2*.

After performing a rolling update to the version *1.0.0*, you will do a rollback to *0.0.2*.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Setup

Before deploying the application `article-service`, you need to deploy the database with:

```sh
kubectl apply -f database.yaml
```


## Deploy the version v0.0.2

Complete the provided <walkthrough-editor-open-file filePath="deployment.yaml">deployment.yaml</walkthrough-editor-open-file> file to indicate the deployment strategy:

```yaml
strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```

Then create the deployment:

```sh
kubectl apply -f deployment.yaml
```

## Ensure everything is fine

List the deployements, get details about `article-service` and verify the pod statuses:

```sh
kubectl get deployments
kubectl describe deployments article-service
kubectl get pods -o wide
```

## Create a service to expose the pods

Here, we create a NodePort service imperatively:

```sh
kubectl expose deployment article-service \
--type=NodePort \
--name=article-svc \
--port=80 \
--target-port=8080
```


Retrieve the external IP of a node and the allocated port.

Then display the service in your web Browser.

In the version 0.0.2, you can add and list articles on the path /.
Add an article with:
```bash
curl -X POST http://EXTERNAL_IP:PORT/ -d '{ "name": "Article 1", "description": "The best article of all times" }'
```
and check it appears in the list from your browser.


Now we want to add a health page on /healthz and move article list on /article.
If you try to access this endpoint it should respond a 404 error:

```bash
 curl -X http://EXTERNAL_IP:PORT/healthz
```

## Deploy a new version of the site

Update the <walkthrough-editor-open-file filePath="deployment.yaml">deployment.yaml</walkthrough-editor-open-file> file to use the `1.0.0` image tag.

Then apply the update:

```sh
kubectl apply -f deployment.yaml
```

Check the pod statuses:

```sh
watch kubectl get pods -o wide
```

Verify you get a new version of the website in your browser by requesting /article and /healthz paths.

## RollBack to v0.0.2

Kubernetes allows to perform rollback of deployment with the `rollout` command.

Perform a rollback for deployment `article-service` and consult its status:

```sh
kubectl rollout undo deployment article-service

kubectl rollout status deployment article-service
```

## Clean

```sh
kubectl delete services article-svc
kubectl delete -f deployment.yaml
kubectl delete -f database.yaml
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

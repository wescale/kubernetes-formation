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

Before deploy the application `article-service` you need to deploy the database.

To do that:
```sh
kubectl apply -f database.yml
```


## Deploy the version v1.0.2

Complete the provided <walkthrough-editor-open-file filePath="deployment-v0.0.2.yaml">deployment-v0.0.2.yaml</walkthrough-editor-open-file> file to indicate the deployment strategy:

```yaml
strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```

Then create the deployment:

```sh
kubectl apply -f deployment-v0.0.2.yaml
```

## Ensure everything is fine

List the deployements, get details about `release-name-article-service` and consult the pod statuses:

```sh
kubectl get deployments
kubectl describe deployments release-name-article-service
kubectl get pods -o wide
```

## Create a service to externally expose the deployment

What are the solutions to expose a service outside the cluster network ?

Here, we create a NodePort service imperatively:

```sh
kubectl expose deployment release-name-article-service \
--type=NodePort \
--name=article-svc \
--port=80 \
--target-port=8080
```

or declaratively with a  <walkthrough-editor-open-file filePath="service.yaml">service.yaml</walkthrough-editor-open-file> file:

```sh
kubectl apply -f service.yaml
```

Retrieve the external IP/port.

Then display the service in your web Browser.

In the version 0.0.2, only the path exists:

* GET / View the articles
* POST / Create an article with a body like that:
```json
{
  "name": "Article 1",
  "description": "The best article of all times"
}
```
* DELETE /{articleId} Delete an article

Try to insert a new article

```bash
 curl -X POST http://EXTERNAL_IP:PORT/ -d '{  
  "name": "Article 1",
  "description": "The best article of all times"
}' 
```

## Deploy a new version of the site

See <walkthrough-editor-open-file filePath="deployment-v1.0.0.yaml">deployment-v1.0.0.yaml</walkthrough-editor-open-file> file, which updates the image tag.

Then apply the update:

```sh
kubectl apply -f deployment-v1.0.0.yaml
```

Check the pod statuses:

```sh
watch kubectl get pods -o wide
```

Verify you get a new version of the website in your browser.

In the release 1.0.1 the paths are updated:

* GET /

* GET /healthz

* GET /article/
* POST /article/
```json
{
  "name": "Article 1",
  "description": "The best article of all times"
}
``````
* DELETE /article/{articleID}


Show the articles with the new path.

## RollBack to v0.0.2

Kubernetes allows to perform rollback of deployment with the `rollout` command.

Perform a rollback for deployment `release-name-article-service` and consult its status:

```sh
kubectl rollout undo deployment release-name-article-service

kubectl rollout status deployment release-name-article-service
```

## Clean

```sh
kubectl delete services article-svc
kubectl delete -f deployment-v0.0.2.yaml
kubectl delete -f database.yaml
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

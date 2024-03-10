
# Exercise 2.6 - Ingress rules

<walkthrough-tutorial-duration duration="30.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will use the same application as in the previous exercise.

You will expose a frontend and the API through an ingress definition.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer: <walkthrough-project-setup></walkthrough-project-setup>

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy the Database

Instead of using a YAML file, use the imperative command `kubectl create` to create a deployment with the following attributes:
- name: `mongo`
- image: `mongo:7`
- port: 27017

> You can use `kubectl help create deploy` for help

Once the deployment is created, expose it as a service with the following attributes:
- name: `mongo`
- type: `ClusterIP`
- ports: 
  - service port: `27017`
  - target port: `27017`
  - protocol: `TCP`

> You can use `kubectl help expose` for help

Ensure the deployment, pod, service and endpoints are OK.
```sh
kubectl get pod,deploy,service,endpoints
```

## Deploy the API

The <walkthrough-editor-open-file filePath="article-api.yaml">article-api.yaml</walkthrough-editor-open-file> file contains 
the definition of the **deployment** AND the **service** of the API in a single file. You can apply it with:

```sh
kubectl apply -f article-api.yaml
```

> Note: The article API will be deployed in the version `2.0` with new routes.

At this point, we have:
- a running MongoDb instance with an `ClusterIP` service to expose it inside the cluster.
- a running Article Api instance with an `ClusterIP` service to expose it inside the cluster. 

## A very basic ingress

Edit and correct the <walkthrough-editor-open-file filePath="article-api.ingress.yaml">article-api.ingress.yaml</walkthrough-editor-open-file> 
file. Then apply it with:

```sh
kubectl apply -f article-api.ingress.yaml
```

Ensure the ingress is correctly created and wait for an external IP address to be defined (it can take 1 or 2 minutes):

```sh
kubectl get ingress -w
```

Once the external IP address is defined, you can test the connectivity to the API with curl or with a web browser:

```sh
curl -v http://<EXTERNAL_IP>/article/
```

> Note that even if the ingress is correctly created, you may need additional minutes in order to be able 
> to connect to the API.

## Deploy the frontend

### The deployment, service and configmap

The <walkthrough-editor-open-file filePath="article-frontend.yaml">article-frontend.yaml</walkthrough-editor-open-file> file contains
the definition of the **deployment**, the **service** and a **configmap** of the frontend in a single file. You can apply it with:

```sh
kubectl apply -f article-frontend.yaml
```

Like you will see, a configmap have been mount inside the pod, as a volume, in order to configure the frontend.

## All together: The ingress

The <walkthrough-editor-open-file filePath="admin.ingress.yaml">admin.ingress.yaml</walkthrough-editor-open-file> file contains
definition for the article administration. It will put together the frontend and the API. Complete the file, we want:
- The `/` path to target the frontend service
- The `/article` path to target the API service
> You can use examples from the [official documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/) if needed.


Then, apply it with:

```sh
kubectl apply -f admin.ingress.yaml
```

Ensure the ingress is correctly created and wait for an external IP address to be defined (it can take several minutes to be fully working):

```sh
kubectl get ingress -w
```

Once everything is ready, you can open a browser and check that everything is working fine:

```
http://<EXTERNAL_IP>/
```

## Clean

```sh
kubectl delete ingress --all
kubectl delete deployment --all
kubectl delete service article-api article-frontend mongo
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

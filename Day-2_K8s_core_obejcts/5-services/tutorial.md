# Exercise 2.5 - Services

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

You will explore the different types of services proposed by kubernetes:
1. Create a `ClusterIP` service
2. Create a `NodePort` service
3. Create a `LoadBalancer` service

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer: <walkthrough-project-setup></walkthrough-project-setup>


Now, you must retrieve the credentials of the kubernetes cluster:
```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

---
## MongoDb

### Create the deployment

Apply the <walkthrough-editor-open-file filePath="mongo.deploy.yaml">mongo.deploy.yaml</walkthrough-editor-open-file> file
we do on the previous exercises to create a deployment for the mongo database.

```sh
kubectl apply -f mongo.deploy.yaml
```

### Create a `ClusterIP` service

Apply the <walkthrough-editor-open-file filePath="mongo.svc.yaml">mongo.svc.yaml</walkthrough-editor-open-file> file.

```sh
kubectl apply -f mongo.svc.yaml
```

**Describe** the service and ensure it has entries in its `endpoints`... 

**Correct** the service file, and apply it again. Check the endpoints again.

## Article API (1)

### Create the deployment

Create the deployment corresponding to the <walkthrough-editor-open-file filePath="article-api.deploy.yaml">article-api.deploy.yaml</walkthrough-editor-open-file> file.
```sh
kubectl apply -f article-api.deploy.yaml
```

Check that de pods are up and running. Take a look to the logs.

## Article API (2)

### Expose the deployment with a NodePort

Now, we'll expose the deployment with a `NodePort` service via a kubectl command:

```sh
kubectl expose deployment article-api --port=8080 --target-port=8080 --name=article-api --type=NodePort
```

> This will create a service named `article-api` that will expose the deployment `article-api` on a specific port on all
> nodes and will forward the traffic to the port `8080` of the pods.

You can retrieve the created service with the following command:

```sh
kubectl get service article-api -o yaml
```

Check the `nodePort` value. 

Get the nodes `EXTERNAL-IP` addresses:
```sh
kubectl get nodes -o wide
```

You may be able to connect to the service using the following command:

```sh
curl -v http://[NODE_IP_ADDRESS]:[NODE_PORT]
```

> Due to firewall rules, you may not be able to connect to the service.
> On GCP, you can open the firewall rule with the following command: 
> `gcloud compute firewall-rules create test-node-port --network main --allow tcp:30000-32767`

## Article API (3)

### Expose the deployment with a LoadBalancer

Remove the previous service:
```sh
kubectl delete service article-api
```

Then, expose the deployment with a `LoadBalancer` service:
```sh
kubectl expose deployment article-api --port=8080 --target-port=8080 --name=article-api --type=LoadBalancer
```

Wait for the service to have an external IP:
```sh
kubectl get services -w
```

You should see something like this:
```
NAME          TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
article-api   LoadBalancer   10.0.25.51   34.76.167.255   8080:32568/TCP   43s
```

Try to access the service:
```sh
curl -v http://[EXTERNAL_IP]:8080
```

## Clean

Delete the services:
```sh
kubectl delete service article-api
kubectl delete service mongo
```

Delete the deployments:
```sh
kubectl delete deployment --all
```

> If you add a firewall rule, then remove it.

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

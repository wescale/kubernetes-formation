# Services

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

You will explore the different types of services proposed by kubernetes:

1. Create a CLUSTER IP service
2. Create a NodePort service
3. Create a LoadBalancer service

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Cluster IP - Create a Deployment

Here is the <walkthrough-editor-open-file filePath="ClusterIP/deployment.yaml">ClusterIP/deployment.yaml</walkthrough-editor-open-file> file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: metrics
      department: sales
  replicas: 3
  template:
    metadata:
      labels:
        app: metrics
        department: sales
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
```

Create the deployment:

```sh
kubectl apply -f ClusterIP/deployment.yaml
```

## Cluster IP - Create a Cluster IP service

Here is the `ClusterIP/service.yaml` service file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-cip-service
spec:
  type: ClusterIP
  selector:
    app: metrics
    department: ingeneering
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```

Create the service:

```sh
kubectl apply -f ClusterIP/service.yaml
```

Describe the service and ensure it has entries in its `endpoints`... if not, correct the <walkthrough-editor-open-file filePath="ClusterIP/service.yaml">ClusterIP/service.yaml</walkthrough-editor-open-file> because it may be incorrect!

## Cluster IP - Test the service connectivity

Describe the service to get the CLUSTER IP.

Try to access the service [CLUSTER_IP]:80.

This does not work. Why?

How can you access the service?

Execute a shell inside a pod of the service:

```sh
kubectl exec # FIND the other arguments
```

Try the curl on <http://my-cip-service.default.svc.cluster.local:80>

## Cluster IP - Clean all resources

```sh
kubectl delete -f ClusterIP/.
```

## Node Port - Create a Deployment

Here is the <walkthrough-editor-open-file filePath="NodePort/my-deployment-50000.yaml">NodePort/my-deployment-50000.yaml</walkthrough-editor-open-file> file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment-50000
spec:
  selector:
    matchLabels:
      app: metrics
      department: engineering
  replicas: 3
  template:
    metadata:
      labels:
        app: metrics
        department: engineering
    spec:
      containers:
      - name: hello
        image: "gcr.io/google-samples/hello-app:2.0"
        env:
        - name: "PORT"
          value: "50000"
```

Create the deployment:

```sh
kubectl apply -f NodePort/my-deployment-50000.yaml
```

## Node Port - Create a Node Port service

Complete the given <walkthrough-editor-open-file filePath="NodePort/service.yaml">NodePort/service.yaml</walkthrough-editor-open-file> file to expose the pods created from the deployment above.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-np-service
spec:
  type: NodePort
  ...
```

Then create the service:

```sh
kubectl apply -f NodePort/service.yaml
```

## Node Port - Test the service connectivity

Determine the public IP of any worker node:

```sh
kubectl get nodes --output wide
```

Decribe the service to get the exposed node port number.

Then access the service:

```sh
curl -v [NODE_IP_ADDRESS]:[NODE_PORT]
# NODE_PORT is the random port given by kube
```

Is everything OK?

Ensure the service has entries in its `endpoints`:

```sh
kubectl describe svc my-np-service
```

Are the pods running?
If yes, debug the situation.

---
Hint: command `kubectl describe pod NAME_OF_YOUR_POD` could help.

Once the deployment fixed, try again to access the service.

## Node Port - Clean all resources

```sh
kubectl delete -f ./NodePort
```

## Load Balancer - Create a Deployment

Complete the given <walkthrough-editor-open-file filePath="LoadBalancer/my-deployment-50001.yaml">LoadBalancer/my-deployment-50001.yaml</walkthrough-editor-open-file> file to add a `readinessProbe`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment-50001
spec:
  selector:
    matchLabels:
      app: products
      department: sales
  replicas: 3
  template:
    metadata:
      labels:
        app: products
        department: sales
    spec:
      containers:
      - name: hello
        image: "gcr.io/google-samples/hello-app:2.0"
        env:
        - name: "PORT"
          value: "50001"
        readinessProbe:
        ...
```

**Note**: the container serves traffic on port 50001 and on the path "/".

Then create the deployment:

```sh
kubectl apply -f LoadBalancer/my-deployment-50001.yaml
```

## Load Balancer - Create a service

Here is the <walkthrough-editor-open-file filePath="LoadBalancer/service.yaml">LoadBalancer/service.yaml</walkthrough-editor-open-file> file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-lb-service
spec:
  type: LoadBalancer
  selector:
    app: products
    department: sales
  ports:
  - protocol: TCP
    port: 60000
    targetPort: 50001
```

Then create the service:

```sh
kubectl apply -f LoadBalancer/service.yaml
```

## Load Balancer - Test the service connectivity

Get the LB external IP:

```sh
kubectl get service my-lb-service -o wide
```

Access the service (It may take minutes for the LB to be configured)

```sh
curl -v http://[LOAD_BALANCER_ADDRESS]:60000
```

## Load Balancer - Clean all resources

```sh
kubectl delete -f ./LoadBalancer
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

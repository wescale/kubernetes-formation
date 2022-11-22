# exercise-5: Cluster IP

You will create a Cluster IP service and access it.

## Create a Deployment

Here is the deployment file:
```
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

```sh 
kubectl apply -f deployment.yaml
```

## Create a Cluster IP service

Here is the service file:
```
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
 
```sh 
kubectl apply -f service.yaml
```

Describe the service and ensure the service has entries in its `endpoints`... if not, correct the `service.yaml` because it may be incorrect!

## Test the service connectivity

Determine the CLUSTER IP.

Access the service: try the [CLUSTER_IP]:80. This does not work. Why? How can you access the service?
>> It doesn't work because CLUSTER IP Service can be only reached inside the cluster IP

Execute a shell inside a pod of the service:
```sh
kubectl exec -it <pod name> /bin/sh
```

Try the curl on http://my-cip-service.default.svc.cluster.local:80

## Clean all resources

```sh
kubectl  delete -f .
```
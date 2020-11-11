# exercise-5: Node Port

You will create a Node Port service and access it.

## Create a Deployment

Here is the deployment file:
```
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

```sh 
kubectl apply -f my-deployment-50000.yaml
```

## Create a Node Port service

```
apiVersion: v1
kind: Service
metadata:
  name: my-np-service
spec:
  type: NodePort
  selector:
    app: metrics
    department: engineering
  ports:
  - protocol: TCP
    port: 80
    targetPort: 50000
    # nodePort: 30007   # NOTE: we dont set the nodePort, it will be taken randomly by default
```

```sh 
kubectl apply -f service.yaml
```

Ensure the service has entries in its `endpoints`:
```sh
kubectl describe svc my-cip-service
```

## Test the service connectivity

Determine the public IP of any worker node:
```
kubectl get nodes --output wide
```

Access the service
```
[NODE_IP_ADDRESS]:[NODE_PORT]
# NODE_PORT is the random port given by kube
```

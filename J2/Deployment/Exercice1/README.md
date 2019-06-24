
# CREATE DEPLOYMENT hello-app version 1.0 with two replicas
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: hello-dep
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-dep 
deployment
  template:
    metadata:
      labels:
        app: hello-dep
    spec:
      containers:
      - image: gcr.io/google-samples/hello-app:1.0
        imagePullPolicy: Always
        name: hello-dep
        ports:
        - containerPort: 8080

# Apply modification
kubectl apply -f hello-v1.yml

# Edit Deployment file to deploy version 2.0
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: hello-dep
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-dep 
deployment
  template:
    metadata:
      labels:
        app: hello-dep
    spec:
      containers:
      - image: gcr.io/google-samples/hello-app:2.0
        imagePullPolicy: Always
        name: hello-dep
        ports:
        - containerPort: 8080

# Apply modification
kubectl apply -f hello-v2.yml

# Scale up 
# Scaling de l'application 
kubectl scale deployment hello-dep --replicas=3

# nettoyage de l'ensemble:
kubectl delete po,deployment,hpa --all
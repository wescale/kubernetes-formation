# Créer un Deployment

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

# Créer un service de type NodePort

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
```

# Vérifier la création du deployment et le service

# Consulter le service
```
kubectl get service my-np-service --output yaml
```

# Récuperer l'adresse IP externe de votre noeuds
```
kubectl get nodes --output wide
```
# Accéder au service
```
[NODE_IP_ADDRESS]:[NODE_PORT]
```

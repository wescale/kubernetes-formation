# Créer un deployment hello-app
```
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
```
# Créer un service LoadBalancer
```
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
# Consulter le service
```
kubectl get service my-lb-service --output yaml
```
# Accéder au service (Attendez quelques minutes que GKE configure l'équilibreur de charge)
```
[LOAD_BALANCER_ADDRESS]:60000
```



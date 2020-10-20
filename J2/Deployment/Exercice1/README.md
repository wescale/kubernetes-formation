
# Créer un fichier de configuration DEPLOYMENT qui permet de déployer le conteneur hello-app de version 1.0 avec deux replicas
```
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
```
# appliquer la modification
```
kubectl apply -f hello-v1.yml
```

# Editer le fichier Deployment pour déployer la version 2.0 de hello-world
```
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
 ```

# Appliquer les modifications
```
kubectl apply -f hello-v2.yml
```

# "Scale up" l'application
```
kubectl scale deployment hello-dep --replicas=3
```
# nettoyage de l'ensemble:
```
kubectl delete deployment --all
```

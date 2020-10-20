# Créer un fichier yaml permettant de créer un pod nginx:

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: development

spec:
  containers:
  - name: nginx
    image: nginx
    command: ["nginx"]
    args: ["-g", "daemon off;", "-q"]
    ports:
    - containerPort: 80
```

# Créer un pod à partir de ce fichier yaml du pod
```
kubectl create -f nginx.yml
```

# Lister les pods lancés et voir les états des pods

```
kubectl get pods
```

# Lister les pods lancés et identifié l'ip du pod

```
kubectl get pods -owide
```

# Positionnez vous au niveau du conteneur nginx:

```
kubectl exec -it nginx -- /bin/bash
```

# Lister les dossiers au niveau du dossier root:

```
ls -l
```

# Créer un fichier.html contenant un texte "Hello shell demo" et le copier le au niveau du /usr/share/nginx/html/

```
echo Hello shell demo > /usr/share/nginx/html/index.html
```

# Tester nginx et hello page

```
curl http://<IP_POD>
```

# Quitter le conteneur et supprimer le pod:

```
kubectl delete pod nginx
```

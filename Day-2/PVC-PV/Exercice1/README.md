
# Voir les StorageClass présents:
```
kubectl get storageClass
kubectl describe storageClass [name storageClass]
```

# Création d'un Persistent Volume Claim pour demander un espace de stockage de 2Gi en  lecture/ecriture
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi

kubectl apply -f pv-claim.yaml
```
#Voir le PV créer automatiquement
```
kubectl get pv
```
#Creation d'un Pod utilisant le Persistent Volument Claim
```
kind: Pod
apiVersion: v1
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
       claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage
```
```
kubectl apply -f pv-pod.yaml
```

# Vérifier le contenu /usr/share/nginx/html dans le pod 
```
kubectl exec -it task-pv-pod bash
```
# Création d'un index.html dans /usr/share/nginx/html  + Supprimer le pod + Recréer Le pod

Véfier que index.html existe encore.

# Nettoyage
```
kubectl delete pvc task-pv-claim
kubectl delete po task-pv-pod
```




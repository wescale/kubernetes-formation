# Déployer une application Web

kubectl run web --image=gcr.io/google-samples/hello-app:1.0 --port=8080

# Exposer le déploiement en tant que service en interne

kubectl expose deployment web2 --target-port=8080 --type=NodePort
kubectl get service web


# Créer une ressource Ingress
kubectl apply -f basic-ingress.yaml

# Accéder à l'application
kubectl get ingress basic-ingress

# Servir plusieurs applications sur un équilibreur de charge 

kubectl run web2 --image=gcr.io/google-samples/hello-app:2.0 --port=8080
kubectl expose deployment web2 --target-port=8080 --type=NodePort

# Nettoyage
kubectl delete ingress basic-ingress
kubectl delete ingress fanout-ingress
kubectl delete deployment web web2
kubectl delete service web web2
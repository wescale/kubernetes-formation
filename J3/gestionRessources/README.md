# Creation d'un nouveau namespace
kubectl create namespace default-mem-example

# Creation d'un LimitRange 

admin/resource/memory-defaults.yaml 

apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container

kubectl apply -f https://k8s.io/examples/admin/resource/memory-defaults.yaml --namespace=default-mem-example

# Utilisation du LimitRange par le conteneur

admin/resource/memory-defaults-pod.yaml 

apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo
spec:
  containers:
  - name: default-mem-demo-ctr
    image: nginx

kubectl apply -f memory-defaults-pod.yaml --namespace=default-mem-example

# Creation du Pod
kubectl apply -f memory-defaults-pod.yaml --namespace=default-mem-example

# Voir les détails du Pod
kubectl get pod default-mem-demo --output=yaml --namespace=default-mem-example

Qu'est ce que vous constatez ?

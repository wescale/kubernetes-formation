# exercise-2: RBAC

In this exercise, you will create a configmap and try to get the config map from a pod, using a service account.


## Create a pod using a service account
```sh
kubectl create serviceaccount myapp
```

Modify the `pod-sa.yaml` file to have the pod using the `myapp` service account.

Then create the pod:
```sh
kubectl create -f pod-sa.yaml
```

## Create a configmap and try to access it from the pod

Create a config map:
```sh
kubectl create configmap myconfig --from-literal data_1=foo
```

Get inside the pod and execute:
```sh
kubectl exec -it pod-sa -- bash
# then display the configmap
kubectl get configmap myconfig
```

Can you explain what happened ?

## Create a Role and a RoleBinding for the service account

Complete the `role.yaml` file to allow read access to configmaps:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: configmap-reader
rules:
- apiGroups: [""] 
  # Complete the file
  ...
```

Create a RoleBinding:
```sh
kubectl create -f binding.yaml
```

Try again to display the configMap inside the pod

Then try to change the configmap

Can you explain what happened ?

## Clean

```sh
kubectl delete -f pod-sa.yaml
kubectl delete -f binding.yaml
kubectl delete -f role.yaml
kubectl delete cm/myconfig
kubectl delete sa/myapp
```
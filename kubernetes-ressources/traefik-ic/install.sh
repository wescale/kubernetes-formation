
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=sebastien.lavayssiere@wescale.fr
kubectl apply -f traefik-rbac.yaml
kubectl apply -f traefik-ds.yaml

# the traefik webui
htpasswd -bc ./auth traefik password
kubectl create secret generic traefik-login --from-file auth -n kube-system
kubectl apply -f traefik-web-ui.yaml


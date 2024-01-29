```sh
kubectl autoscale deployment article-service --cpu-percent=50 --min=1 --max=10
```
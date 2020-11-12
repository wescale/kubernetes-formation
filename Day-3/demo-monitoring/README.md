# This is a demo for monitoring using Prometheus, Grafana and AlertManager

You will install the [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) which is a ready to use complete monitoring stack.

## Install kube-prometheus

```sh
git clone https://github.com/prometheus-operator/kube-prometheus

cd kube-prometheus
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/
````

Take a look a the manifests. In particular the CustomResourceDefinition in the folder `manifests/setup`:
* ServiceMonitor
* PodeMonitor
* ClusterRole
* PrometheusOperator deployment

Now you can access the services:
```sh
kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090 &
kubectl --namespace monitoring port-forward svc/grafana 3000 &
kubectl --namespace monitoring port-forward svc/alertmanager-main 9093 &
```

And open the following URLs:
* Prometheus [http://localhost:9090](http://localhost:9090)
  * See its configuration, targets and some metrics
* Grafana [http://localhost:3000](http://localhost:3000)
  * admin/admin.
* AlertManager [http://localhost:9093](http://localhost:9093)

## Question

How could you avoid port forwarding and directly access the services?

## Add dashboards on Grafana

Add the [Kubernetes Cluster (Prometheus)](https://grafana.com/grafana/dashboards/6417) dashboard.

## Create monitoring for a group of pods

Create a pod which exposes metrics endpoints:
* For that, use the image `fabxc/instrumented_app`. It exposes the port 8080 as a named port `web`
* Set the labels:
  * `monitoring: "true"`
  * `app: "demo-prom-pod"`

```sh
kubectl create -f pod.yml
```

Once the pod is created, view the returned metrics executng a `curl` command on localhost:8080.

What is the data format exepected by Prometheus?

By defining a `PodMonitor` resource, Prometheus will automatically add the targetted pods to its scrape configuration.
Then, it will request the default `/metrics` endpoint of those pods.

Create a `PodMonitor` resource:
```
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: demo-prom-pod
  labels:
    app: demo-prom-pod
spec:
  selector:
    matchLabels:
      monitoring: "true"
      app: demo-prom-pod
  podMetricsEndpoints:
  - port: web
```

```sh
kubectl create -f pod-monitor.yml
```

Wait 1 minute and see the list of targets on Prometheus.
Do you see your pod ?

## Create monitoring for a service

Create the deployment and service:
```sh
kubectl create -f deployment.yml
```

Create the ServiceMonitor which targets the created abovce service:
```
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: demo-prom-app
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      app: demo-prom-app
  endpoints:
  - port: web
```

```sh
kubectl create -f service-monitor.yml
```

Wait 1 minute and see the list of targets on Prometheus.
Do you see your pod attached to the `demo-prom-app` service?
# Monitoring using Prometheus, Grafana and AlertManager

You will install the [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus) which is a ready to use complete monitoring stack.

## Install kube-prometheus

```sh
git clone https://github.com/prometheus-operator/kube-prometheus

cd kube-prometheus
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/
````

Take a look a the manifests. 

In particular the CustomResourceDefinition in the folder `manifests/setup`:
* ServiceMonitor
* PodeMonitor
* ClusterRole
* PrometheusOperator deployment

Those services are ClusterIP: they are only internal to the cluster.
If you want to reach them, you can use port forward, or create additional k8s resources.

### Access the service using port-forward

Use `ssh -L` option to forward ports 9090, 3000 and 9093 from the bastion.

Then on the bastion,  use the `port-forward` kubectl command:
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

### Access the services using additional k8s resources

Create new NodePort Services.
Open your browser on the DNS for workers (aks the trainer).

## Add dashboards on Grafana

Add the [Kubernetes Cluster (Prometheus)](https://grafana.com/grafana/dashboards/6417) dashboard.

## Create monitoring for a group of pods

Create a pod which exposes metrics endpoints:
* For that, use the image `fabxc/instrumented_app`. It exposes the port 8080 as a named port `web`
* Set the labels:
  * `monitoring: "true"`
  * `app: "demo-prom-pod"`

```sh
kubectl create -f pod.yaml
```

Once the pod is created, view the returned metrics executing a `curl` command on localhost:8080/metrics.

What is the data format expected by Prometheus?

By defining a `PodMonitor` resource, Prometheus will automatically add the targeted pods to its scrape configuration.
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
kubectl create -f pod-monitor.yaml
```

Wait 1 minute and see the list of targets on Prometheus.
Do you see your pod ?

## Create monitoring for a service

Create the deployment and service:
```sh
kubectl create -f deployment.yaml
```

Create the ServiceMonitor which targets the created above service:
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

## Bonus-1: create a Grafana Dashboard to view the number of pods in demo-prom-app service

## Bonus-2: create a PrometheusRule to monitor the number of pods in your service

Create a [PrometheusRule](https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#prometheusrule), to ensure you have at least one  demo-prom-app pod.

N.B: inspect the `ruleSelector` of the Prometheus (namespace monitoring) to be sure your rule will be taken into account.

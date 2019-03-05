
##### Table of Contents

 * [Step One: Create the Redis master pod](#step-one)
 * [Step Two: Create the Redis master service](#step-two)
 * [Step Three: Create the Redis slave pods](#step-three)
 * [Step Four: Create the Redis slave service](#step-four)
 * [Step Five: Create the guestbook pods](#step-five)
 * [Step Six: Create the guestbook service](#step-six)
 * [Step Seven: View the guestbook](#step-seven)
 * [Step Seven bis: View the guestbook by ingress](#step-seven-bis)
 * [Step Eight: Cleanup](#step-eight)

### Step One: Create the Redis master pod<a id="step-one"></a>

Use the `redis-master-deploy.yaml` file to create a Deployment and Redis master . The pod runs a Redis key-value server in a container. Using a deployment is the preferred way to launch long-running pods, even for 1 replica, so that the pod benefits from the self-healing mechanism in Kubernetes (keeps the pods alive).

1. Use the "redis-master-deploy.yaml" file to create the Redis master deployment in your Kubernetes cluster by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f redis-master-deploy.yaml
    ```

2. To verify that the redis-master controller is up, list the deployments you created in the cluster with the `kubectl get deployment` command(if you don't specify a `--namespace`, the `default` namespace will be used. The same below):

    ```console
    $ kubectl get deployment -o wide
    CONTROLLER             CONTAINER(S)            IMAGE(S)                    SELECTOR                         REPLICAS
    redis-master           redis-master            gurpartap/redis             app=redis,role=master            1
    ...
    ```

    Result: The deployment then creates the single Redis master pod.

3. To verify that the redis-master pod is running, list the pods you created in cluster with the `kubectl get pods` command:

    ```console
    $ kubectl get pods
    NAME                        READY     STATUS    RESTARTS   AGE
    redis-master-xx4uv          1/1       Running   0          1m
    ...
    ```

    Result: You'll see a single Redis master pod and the machine where the pod is running after the pod gets placed (may take up to thirty seconds).

### Step Two: Create the Redis master service <a id="step-two"></a>

A Kubernetes [service](https://kubernetes.io/docs/concepts/services-networking/service/) is a named load balancer that proxies traffic to one or more pods. The services in a Kubernetes cluster are discoverable inside other pods via environment variables or DNS.

Services find the pods to load balance based on pod labels. The pod that you created in Step One has the label `app=redis` and `role=master`. The selector field of the service determines which pods will receive the traffic sent to the service.

1. Use the "redis-master-service.yaml" file to create the service in your Kubernetes cluster by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f redis-master-service.yaml
    services/redis-master
    ```

2. To verify that the redis-master service is up, list the services you created in the cluster with the `kubectl get services -o wide` command:

    ```console
    $ kubectl get services
    NAME              CLUSTER_IP       EXTERNAL_IP       PORT(S)       SELECTOR               AGE
    redis-master      10.0.136.3       <none>            6379/TCP      app=redis,role=master  1h
    ...
    ```

    Result: All new pods will see the `redis-master` service running on the host (`$REDIS_MASTER_SERVICE_HOST` environment variable) at port 6379, or running on `redis-master:6379`. After the service is created, the service proxy on each node is configured to set up a proxy on the specified port (in our example, that's port 6379).


### Step Three: Create the Redis slave pods <a id="step-three"></a>

The Redis master we created earlier is a single pod (REPLICAS = 1), while the Redis read slaves we are creating here are 'replicated' pods. In Kubernetes, a deployment is responsible for managing the multiple instances of a replicated pod.

1. Use the file "redis-slave-deploy.yaml" to create the deployment by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f redis-slave-deploy.yaml
    ```

2. To verify that the redis-slave controller is running, run the `kubectl get deploy -o wide` command:

    ```console
    CONTROLLER              CONTAINER(S)            IMAGE(S)                         SELECTOR                    REPLICAS
    redis-master            redis-master            redis                            app=redis,role=master       1
    redis-slave             redis-slave             kubernetes/redis-slave:v2        app=redis,role=slave        2
    ...
    ```

    Result: The deployment creates and configures the Redis slave pods through the redis-master service (name:port pair, in our example that's `redis-master:6379`).

    Example:
    The Redis slaves get started by the deployment with the following command:

    ```console
    redis-server --slaveof redis-master 6379
    ```

3. To verify that the Redis master and slaves pods are running, run the `kubectl get pods` command:

    ```console
    $ kubectl get pods
    NAME                          READY     STATUS    RESTARTS   AGE
    redis-master-xx4uv            1/1       Running   0          18m
    redis-slave-b6wj4             1/1       Running   0          1m
    redis-slave-iai40             1/1       Running   0          1m
    ...
    ```

    Result: You see the single Redis master and two Redis slave pods.

### Step Four: Create the Redis slave service <a id="step-four"></a>

Just like the master, we want to have a service to proxy connections to the read slaves. In this case, in addition to discovery, the Redis slave service provides transparent load balancing to clients.

1. Use the "redis-slave-service.yaml" file to create the Redis slave service by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f redis-slave-service.yaml
    services/redis-slave
    ```

2. To verify that the redis-slave service is up, list the services you created in the cluster with the `kubectl get services -o wide` command:

    ```console
    NAME              CLUSTER_IP       EXTERNAL_IP       PORT(S)       SELECTOR               AGE
    redis-master      10.0.136.3       <none>            6379/TCP      app=redis,role=master  1h
    redis-slave       10.0.21.92       <none>            6379/TCP      app-redis,role=slave   1h
    ...
    ```

    Result: The service is created with labels `app=redis` and `role=slave` to identify that the pods are running the Redis slaves.

Tip: It is helpful to set labels on your services themselves--as we've done here--to make it easy to locate them later.

### Step Five: Create the guestbook pods <a id="step-five"></a>

This is a simple Go `net/http` ([negroni](https://github.com/codegangsta/negroni) based) server that is configured to talk to either the slave or master services depending on whether the request is a read or a write. The pods we are creating expose a simple JSON interface and serves a jQuery-Ajax based UI. Like the Redis read slaves, these pods are also managed by a deployment.

1. Use the "guestbook-deploy.yaml" file to create the guestbook deployment by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f guestbook-deploy.yaml
    ```

 Tip: If you want to modify the guestbook code open the `_src` of this example and read the README.md and the Makefile. If you have pushed your custom image be sure to update the `image` accordingly in the guestbook-controller.yaml.

2. To verify that the guestbook deployment is running, run the `kubectl get deploy -o wide` command:

    ```console
    CONTROLLER            CONTAINER(S)         IMAGE(S)                               SELECTOR                  REPLICAS
    guestbook             guestbook            k8s.gcr.io/guestbook:v3                app=guestbook             3
    redis-master          redis-master         redis                                  app=redis,role=master     1
    redis-slave           redis-slave          kubernetes/redis-slave:v2              app=redis,role=slave      2
    ...
    ```

3. To verify that the guestbook pods are running (it might take up to thirty seconds to create the pods), list the pods you created in cluster with the `kubectl get pods` command:

    ```console
    $ kubectl get pods
    NAME                           READY     STATUS    RESTARTS   AGE
    guestbook-3crgn                1/1       Running   0          2m
    guestbook-gv7i6                1/1       Running   0          2m
    guestbook-x405a                1/1       Running   0          2m
    redis-master-xx4uv             1/1       Running   0          23m
    redis-slave-b6wj4              1/1       Running   0          6m
    redis-slave-iai40              1/1       Running   0          6m
    ... 
    ```

    Result: You see a single Redis master, two Redis slaves, and three guestbook pods.

### Step Six: Create the guestbook service <a id="step-six"></a>

Just like the others, we create a service to group the guestbook pods but this time, to make the guestbook front end externally visible, we specify `"type": "LoadBalancer"`.

1. Use the "guestbook-service.yaml" file to create the guestbook service by running the `kubectl apply -f` *`filename`* command:

    ```console
    $ kubectl apply -f guestbook-service.yaml
    ```


2. To verify that the guestbook service is up, list the services you created in the cluster with the `kubectl get services` command:

    ```console
    $ kubectl get services
    NAME              CLUSTER_IP       EXTERNAL_IP       PORT(S)               SELECTOR               AGE
    guestbook         10.0.217.218     <none>            3000/TCP,xxx/TCP      app=guestbook          1h
    redis-master      10.0.136.3       <none>            6379/TCP              app=redis,role=master  1h
    redis-slave       10.0.21.92       <none>            6379/TCP              app-redis,role=slave   1h
    ...
    ```

    Result: The service is created with label `app=guestbook`.

### Step Seven: View the guestbook <a id="step-seven"></a>

You can now play with the guestbook that you just created by opening it in a browser (it might take a few moments for the guestbook to come up).

 * **Remote Host:**
    1. To view the guestbook on a remote host, locate the external IP of one node with `kubectl get nodes -o wide` output. 

    2. Append port get by `kubectl get svc` (xxx here) to the IP address (for example `http://146.148.81.8:xxx`), and then navigate to that address in your browser.

### Step seven bis - Ingress<a id="step-seven-bis"></a>

You already have an Traefik Ingress Controller !

You can get the UI:

```
kubectl get svc -n kube-system
```

You can see the TraefikWebUI:
```
http://{IPOfTheLoadBalancer}:8080
```

to see how add an Ingress [follow this link](https://docs.traefik.io/user-guide/kubernetes/#submitting-an-ingress-to-the-cluster)

Exemple:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: guestbook-go-ing
  namespace: default
  annotations:
    kubernetes.io/ingress.class: traefik
    traefik.ingress.kubernetes.io/rule-type: PathPrefixStrip
spec:
  rules:
  - http:
      paths:
      - path: /guestbook
        backend:
          serviceName: guestbook
          servicePort: 3000
```

Warning !

You have to change image in "guestbook" Deployment, please use "eu.gcr.io/sandbox-wescale/guestbook-go:with-guestbook-url-2" instead of "k8s.gcr.io/guestbook:v3".

It's just works :-)

### Step Eight: Cleanup <a id="step-eight"></a>

After you're done playing with the guestbook, you can cleanup by deleting the guestbook service and removing the associated resources that were created, including load balancers, forwarding rules, target pools, and Kubernetes deployments and services.

Delete all the resources by running the following `kubectl delete -f` *`filename`* command:

```console
$ kubectl delete -f .
```



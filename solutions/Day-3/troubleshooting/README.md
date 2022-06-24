# List of errors

Look for `# HERE` inside [k8s-troubleshooting.yml](../../../kubernetes-ressources/terraform/k8s-troubleshooting.yml):
* invalid selector in service wordpress
* invalid env var MARIA_DB_HOST in wordpress deployment
* invalid registry name for mariadb depl: should be `docker.io/bitnami/mariadb:10.5.15-debian-10-r40`
* invalid readiness probe for maria db

# Strategy

At a first glance, some pods are in undesired states: `ImagePullBackOff` and `CrashLoopBackOff`.
A valid state is to get all pods `Running` and `Ready`.

## Let's start wit the dabatabase

1. First start by fixing `ImagePullBackOff` for mariadb pods.
  * fix value `docker.io/bitnami/mariadb:10.5.15-debian-10-r40` in the statefulset, then delete the `pod/wordpress-mariadb-0` to force a new creation as a pod managed by a statefulset is not automatically recreated.
2. Now, you see the `pod/wordpress-mariadb-0` never becomes ready. If you describe it, you understand the readiness probe fails because of an `exit 1`. Fix the probe in the stateful set, then delete again the pod to ask a new creation.
3. To ensure everything is fine for the DB, run `kubectl describe service/wordpress-mariadb -n application` to check the endpoints.

## Let's start wit the wordpress container

1. If the you describe the `wordpress` pod, you see its readiness probe fails. Look at the logs, you see a Warning related to a `WRONG_DNS_ENTRY`. This value is in the container environment variable to define the `MARIADB_HOST`. Fix the value to use `wordpress-mariadb` in the `wordpress` deployment. Wait for a new pod to be created, or delete the old pod.

## Fix the wordpress service.

1. If you describe the services, you see the `wordpress` service has no endpoint. This is due to an invalid selector. Fix the `wordpress` service to use the following selector:
```sh
 selector:
    app.kubernetes.io/name: wordpress
    app.kubernetes.io/instance: wordpress
```

## Test the wordpress app

Access the service via the NodePort service named `wordpress`.
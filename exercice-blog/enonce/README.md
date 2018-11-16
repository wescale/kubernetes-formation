# Persistent Installation of MySQL and WordPress on Kubernetes

This example describes how to run a persistent installation of
[WordPress](https://wordpress.org/) and
[MySQL](https://www.mysql.com/) on Kubernetes. We'll use the
[mysql](https://registry.hub.docker.com/_/mysql/) and
[wordpress](https://registry.hub.docker.com/_/wordpress/) official
[Docker](https://www.docker.com/) images for this installation. (The
WordPress image includes an Apache server).

Demonstrated Kubernetes Concepts:

* [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) to
  define persistent disks (disk lifecycle not tied to the Pods).
* [Services](https://kubernetes.io/docs/concepts/services-networking/service/) to enable Pods to
  locate one another.
* [External Load Balancers](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)
  to expose Services externally.
* [Deployments](http://kubernetes.io/docs/user-guide/deployments/) to ensure Pods
  stay up and running.
* [Secrets](http://kubernetes.io/docs/user-guide/secrets/) to store sensitive
  passwords.

## Table of Contents

* [Persistent Installation of MySQL and WordPress on Kubernetes](#persistent-installation-of-mysql-and-wordpress-on-kubernetes)
  * [Quickstart](#quickstart)
  * [Table of Contents](#table-of-contents)
  * [Create the MySQL Password Secret](#create-the-mysql-password-secret)
  * [Deploy MySQL](#deploy-mysql)
  * [Deploy WordPress](#deploy-wordpress)
  * [Visit your new WordPress blog](#visit-your-new-wordpress-blog)
  * [Take down and restart your blog](#take-down-and-restart-your-blog)
  * [Next Steps](#next-steps)

## Create the MySQL Password Secret

Use a [Secret](http://kubernetes.io/docs/user-guide/secrets/) object
to store the MySQL password. First create a file (in the same directory
as the wordpress sample files) called
`password.txt` and save your password in it. Make sure to not have a
trailing newline at the end of the password. The first `tr` command
will remove the newline if your editor added one. Then, create the
Secret object.

```shell
tr --delete '\n' <password.txt >.strippedpassword.txt && mv .strippedpassword.txt password.txt
kubectl create secret generic mysql-pass --from-file=password.txt
```

This secret is referenced by the MySQL and WordPress pod configuration
so that those pods will have access to it. The MySQL pod will set the
database password, and the WordPress pod will use the password to
access the database.

## Deploy MySQL

Now that the persistent disks and secrets are defined, the Kubernetes
pods can be launched. Start MySQL using
[mysql-deployment.yaml](mysql-deployment.yaml).

Take a look at [mysql-deployment.yaml](mysql-deployment.yaml), and
note that we've defined a volume mount for `/var/lib/mysql`, and then
created a Persistent Volume Claim that looks for a 20G volume. This
claim is satisfied by any volume that meets the requirements, in our
case one of the volumes we created above.

Also look at the `env` section and see that we specified the password
by referencing the secret `mysql-pass` that we created above. Secrets
can have multiple key:value pairs. Ours has only one key
`password.txt` which was the name of the file we used to create the
secret. The [MySQL image](https://hub.docker.com/_/mysql/) sets the
database password using the `MYSQL_ROOT_PASSWORD` environment
variable.

It may take a short period before the new pod reaches the `Running`
state.  List all pods to see the status of this new pod.

```shell
kubectl get pods
```

```shell
NAME                          READY     STATUS    RESTARTS   AGE
wordpress-mysql-cqcf4-9q8lo   1/1       Running   0          1m
```

Kubernetes logs the stderr and stdout for each pod. Take a look at the
logs for a pod by using `kubectl log`. Copy the pod name from the
`get pods` command, and then:

```shell
kubectl logs <pod-name>
```

```shell
...
2016-02-19 16:58:05 1 [Note] InnoDB: 128 rollback segment(s) are active.
2016-02-19 16:58:05 1 [Note] InnoDB: Waiting for purge to start
2016-02-19 16:58:05 1 [Note] InnoDB: 5.6.29 started; log sequence number 1626007
2016-02-19 16:58:05 1 [Note] Server hostname (bind-address): '*'; port: 3306
2016-02-19 16:58:05 1 [Note] IPv6 is available.
2016-02-19 16:58:05 1 [Note]   - '::' resolves to '::';
2016-02-19 16:58:05 1 [Note] Server socket created on IP: '::'.
2016-02-19 16:58:05 1 [Warning] 'proxies_priv' entry '@ root@wordpress-mysql-cqcf4-9q8lo' ignored in --skip-name-resolve mode.
2016-02-19 16:58:05 1 [Note] Event Scheduler: Loaded 0 events
2016-02-19 16:58:05 1 [Note] mysqld: ready for connections.
Version: '5.6.29'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
```

Also in [mysql-deployment.yaml](mysql-deployment.yaml) we created a
service to allow other pods to reach this mysql instance. The name is
`wordpress-mysql` which resolves to the pod IP.

Up to this point one Deployment, one Pod, one PVC, one Service, one Endpoint,
two PVs, and one Secret have been created, shown below:

```shell
kubectl get deployment,pod,svc,endpoints,pvc -l app=wordpress -o wide && \
  kubectl get secret mysql-pass && \
  kubectl get pv
```

```shell
NAME                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/wordpress-mysql   1         1         1            1           3m
NAME                                  READY     STATUS    RESTARTS   AGE       IP           NODE
po/wordpress-mysql-3040864217-40soc   1/1       Running   0          3m        172.17.0.2   127.0.0.1
NAME                  CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE       SELECTOR
svc/wordpress-mysql   None         <none>        3306/TCP   3m        app=wordpress,tier=mysql
NAME                 ENDPOINTS         AGE
ep/wordpress-mysql   172.17.0.2:3306   3m
NAME                 STATUS    VOLUME       CAPACITY   ACCESSMODES   AGE
pvc/mysql-pv-claim   Bound     local-pv-2   20Gi       RWO           3m
NAME         TYPE      DATA      AGE
mysql-pass   Opaque    1         3m
NAME         CAPACITY   ACCESSMODES   STATUS      CLAIM                    REASON    AGE
local-pv-1   20Gi       RWO           Available                                      3m
local-pv-2   20Gi       RWO           Bound       default/mysql-pv-claim             3m
```

## Deploy WordPress

Next deploy WordPress using
[wordpress-deployment.yaml](wordpress-deployment.yaml).

Here we are using many of the same features, such as a volume claim
for persistent storage and a secret for the password.

The [WordPress image](https://hub.docker.com/_/wordpress/) accepts the
database hostname through the environment variable
`WORDPRESS_DB_HOST`. We set the env value to the name of the MySQL
service we created: `wordpress-mysql`.

```shell
kubectl get services wordpress
```

```shell
NAME        CLUSTER-IP     EXTERNAL-IP     PORT(S)   AGE
wordpress   10.0.0.5       1.2.3.4         80/TCP    19h
```

## Visit your new WordPress blog

Now, we can visit the running WordPress app. Use the external IP of
the service that you obtained above.

```shell
http://<external-ip>
```

You should see the familiar WordPress init page.

![WordPress init page](WordPress.png "WordPress init page")

> Warning: Do not leave your WordPress installation on this page. If
> it is found by another user, they can set up a website on your
> instance and use it to serve potentially malicious content. You
> should either continue with the installation past the point at which
> you create your username and password, delete your instance, or set
> up a firewall to restrict access.

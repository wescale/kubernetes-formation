# List of errors

Look for `# HERE` inside the private gitlab repo [k8s-troubleshooting.yml](https://gitlab.prod.aws.wescale.fr/wescalefr/training/kubernetes-fondamentaux/-/blob/main/k8s-troubleshooting.yml?ref_type=heads):
* invalid selector in service wordpress
* invalid env var MARIA_DB_HOST in wordpress deployment
* invalid registry name for mariadb depl: should be `docker.io/bitnami/mariadb:10.5.15-debian-10-r40`
* invalid readiness probe for maria db

# Strategy

At a first glance, some pods are in undesired states: `ImagePullBackOff` and `CrashLoopBackOff`.
A valid state is to get all pods `Running` and `Ready`.

save time

```sh
kubectl config set-context --current --namespace=application
```


Look at https://github.com/wescale/microservices-demo?hl=fr to understand the component involved

```
mathieu_the_trainer@cloudshell:~/cloudshell_open/kubernetes-formation-22$ k get all -n application
NAME                                       READY   STATUS             RESTARTS          AGE
pod/article-service-74cdd95d5-tkpp9        0/1     CrashLoopBackOff   279 (4m42s ago)   20h
pod/cart-service-5d7bc8c474-xxcl6          1/1     Running            0                 20h
pod/front-admin-6667fc96-jltml             0/1     ImagePullBackOff   0                 20h
pod/front-user-64b84dbf8d-9mt7t            0/1     ImagePullBackOff   0                 20h
pod/microservices-mongo-5bc5f9fcb7-g4qqr   0/1     Running            0                 20h
pod/microservices-redis-765448c6c8-m6pd8   0/1     ErrImagePull       0                 20h
pod/reverse-proxy-587948898d-548b8         0/1     CrashLoopBackOff   244 (61s ago)     20h

NAME                            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/article-service         ClusterIP   10.236.11.233   <none>        8080/TCP         2d19h
service/cart-service            ClusterIP   10.236.14.144   <none>        8081/TCP         2d19h
service/front-admin             ClusterIP   10.236.3.229    <none>        80/TCP           2d19h
service/front-user              ClusterIP   10.236.5.163    <none>        80/TCP           2d19h
service/microservices-mongodb   ClusterIP   10.236.6.146    <none>        27017/TCP        2d19h
service/microservices-redis     ClusterIP   10.236.4.186    <none>        6379/TCP         2d19h
service/reverse-proxy           NodePort    10.236.12.38    <none>        8080:31000/TCP   2d19h

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/article-service       0/1     1            0           2d19h
deployment.apps/cart-service          1/1     1            1           2d19h
deployment.apps/front-admin           0/1     1            0           2d19h
deployment.apps/front-user            0/1     1            0           2d19h
deployment.apps/microservices-mongo   0/1     1            0           2d19h
deployment.apps/microservices-redis   0/1     1            0           2d19h
deployment.apps/reverse-proxy         0/1     1            0           2d19h

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/article-service-74cdd95d5        1         1         0       2d19h
replicaset.apps/cart-service-5d7bc8c474          1         1         1       2d19h
replicaset.apps/front-admin-6667fc96             1         1         0       2d19h
replicaset.apps/front-user-64b84dbf8d            1         1         0       2d19h
replicaset.apps/microservices-mongo-5bc5f9fcb7   1         1         0       2d19h
replicaset.apps/microservices-redis-765448c6c8   1         1         0       2d19h
replicaset.apps/reverse-proxy-587948898d         1         1         0       2d19h


k get -n application event
LAST SEEN   TYPE      REASON              OBJECT                                      MESSAGE
10m         Warning   Unhealthy           pod/article-service-74cdd95d5-tkpp9         Readiness probe failed: Get "http://10.232.0.12:8080/": dial tcp 10.232.0.12:8080: connect: connection refused
43s         Warning   BackOff             pod/article-service-74cdd95d5-tkpp9         Back-off restarting failed container article-service in pod article-service-74cdd95d5-tkpp9_application(42bcba9f-9ee2-432e-a9d2-2c43144da42e)
33s         Normal    Pulling             pod/front-admin-6667fc96-jltml              Pulling image "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-admin:1.0.0"
10m         Normal    BackOff             pod/front-admin-6667fc96-jltml              Back-off pulling image "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-admin:1.0.0"
37s         Normal    BackOff             pod/front-user-64b84dbf8d-9mt7t             Back-off pulling image "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-user:1.0.0"
35s         Warning   Unhealthy           pod/microservices-mongo-5bc5f9fcb7-g4qqr    Readiness probe failed: Bye bye!
5m33s       Normal    BackOff             pod/microservices-redis-765448c6c8-m6pd8    Back-off pulling image "redls:7-alpine"
3m52s       Normal    SuccessfulDelete    replicaset/microservices-redis-765448c6c8   Deleted pod: microservices-redis-765448c6c8-m6pd8
3m55s       Normal    Scheduled           pod/microservices-redis-bbf9569f9-sj7jt     Successfully assigned application/microservices-redis-bbf9569f9-sj7jt to gke-training-cluster-default-pool-beb01467-xrqt
3m55s       Normal    Pulling             pod/microservices-redis-bbf9569f9-sj7jt     Pulling image "redis:7-alpine"
3m53s       Normal    Pulled              pod/microservices-redis-bbf9569f9-sj7jt     Successfully pulled image "redis:7-alpine" in 1.764163174s (1.764181028s including waiting)
3m53s       Normal    Created             pod/microservices-redis-bbf9569f9-sj7jt     Created container microservices-redis
3m53s       Normal    Started             pod/microservices-redis-bbf9569f9-sj7jt     Started container microservices-redis
3m55s       Normal    SuccessfulCreate    replicaset/microservices-redis-bbf9569f9    Created pod: microservices-redis-bbf9569f9-sj7jt
3m55s       Normal    ScalingReplicaSet   deployment/microservices-redis              Scaled up replica set microservices-redis-bbf9569f9 to 1
3m52s       Normal    ScalingReplicaSet   deployment/microservices-redis              Scaled down replica set microservices-redis-765448c6c8 to 0 from 1
40s         Warning   BackOff             pod/reverse-proxy-587948898d-548b8          Back-off restarting failed container reverse-proxy in pod reverse-proxy-587948898d-548b8_application(10a

 ```

## Let's start with the redis

 ```sh
k describe -n application pod/microservices-redis-<TAB>
  Back-off pulling image "redls:7-alpine" 

 k edit -n application deployment.apps/microservices-redis  
  # rename redls:7-alpine to redis:7-alpine

```


## Let's fix mongo

The mongo pod is not ready but logs are OK

 ```sh
k describe pod/microservices-mongo-5bc5f9fcb7-<TAB>
  Events:
  Type     Reason     Age                     From     Message
  ----     ------     ----                    ----     -------
  Warning  Unhealthy  4m42s (x8398 over 20h)  kubelet  Readiness probe failed: Bye bye!

 k edit deployment.apps/microservices-mongo  
  # remove 2 line in the readynessProbe
  # echo "Byebye" 
  # exit 1

```


## Let's fix Article Microservice

 ```sh
 k describe pod/article-service-74cdd95d5-tkpp9
  Events:
    Type     Reason     Age                     From     Message
    ----     ------     ----                    ----     -------
    Warning  Unhealthy  27m (x720 over 20h)     kubelet  Readiness probe failed: Get "http://10.232.0.12:8080/": dial tcp 10.232.0.12:8080: connect: connection refused
    Warning  BackOff    2m31s (x5777 over 20h)  kubelet  Back-off restarting failed container article-service in pod article-service-74cdd95d5-tkpp9_application(42bcba9f-9ee2-432e-a9d2-2c43144da42e)


 k logs pod/article-service-74cdd95d5-tkpp9
time="2024-03-10T10:54:38Z" level=info msg="-= Article Service =-"
time="2024-03-10T10:54:38Z" level=warning msg="open config.yaml: no such file or directory"
time="2024-03-10T10:54:43Z" level=error msg="Failed to connect to mongodb://root:KubernetesTraining@microservices-mongo:27017"
time="2024-03-10T10:54:43Z" level=panic msg="Unable to ping the database: server selection error: context deadline exceeded, current topology: { Type: Unknown, Servers: [{ Addr: microservices-mongo:27017, Type: Unknown, Last error: dial tcp: lookup microservices-mongo on 10.236.0.10:53: no such host }, ] }"
panic: (*logrus.Entry) 0xc00015e150

goroutine 1 [running]:
github.com/sirupsen/logrus.(*Entry).log(0xc00015e070, 0x0, {0xc000212240, 0x106})
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/entry.go:260 +0x491
github.com/sirupsen/logrus.(*Entry).Log(0xc00015e070, 0x0, {0xc000497e00?, 0x934f25?, 0xf93680?})
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/entry.go:304 +0x48
github.com/sirupsen/logrus.(*Entry).Logln(0xc00015e070, 0x0, {0xc000497ec8?, 0x10?, 0x9ba560?})
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/entry.go:394 +0x7f
github.com/sirupsen/logrus.(*Logger).Logln(0xf93640, 0x0, {0xc000497ec8, 0x1, 0x1})
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/logger.go:298 +0x58
github.com/sirupsen/logrus.(*Logger).Panicln(...)
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/logger.go:339
github.com/sirupsen/logrus.Panicln(...)
        /go/pkg/mod/github.com/sirupsen/logrus@v1.9.3/exported.go:264
main.initDatabase()
        /app/main.go:40 +0xef
main.main()
        /app/main.go:16 +0x54   
 


 ```
The hostname `microservices-mongo` check the service name (equals to DNS name)

k get svc | grep mongo
microservices-mongodb   ClusterIP   10.236.6.146    <none>        27017/TCP        2d19h

the service name is `microservices-mongodb` not  `microservices-mongo`

k edit deployments.apps article-service to fix


 ## check all service endpoint

```sh
k get endpoints
  NAME                    ENDPOINTS           AGE
  article-service         <none>              2d20h
  cart-service            10.232.1.22:8081    2d20h
  front-admin             10.232.0.24:80      2d20h
  front-user              10.232.0.25:80      2d20h
  microservices-mongodb   10.232.2.47:27017   2d20h
  microservices-redis     10.232.2.46:6379    2d20h
  reverse-proxy           10.232.0.26:80      2d20h

  # article-service as no endpoint
  # selector ou port number issue ?
```

  in deployment :
```sh
    selector:
    matchLabels:
      app.kubernetes.io/instance: microservices
      app.kubernetes.io/name: article-service
```

in service :
```sh
  selector:
    app.kubernetes.io/instance: nicroservices # n instead of m
    app.kubernetes.io/name: article-serivce # serivce instead of service
```

 ## Test

```sh
  # retrive a node public IP
  k get node -o wide

  # check nodeport external port
  k get svc
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
article-service         ClusterIP   10.236.11.233   <none>        8080/TCP         2d20h
cart-service            ClusterIP   10.236.14.144   <none>        8081/TCP         2d20h
front-admin             ClusterIP   10.236.3.229    <none>        80/TCP           2d20h
front-user              ClusterIP   10.236.5.163    <none>        80/TCP           2d20h
microservices-mongodb   ClusterIP   10.236.6.146    <none>        27017/TCP        2d20h
microservices-redis     ClusterIP   10.236.4.186    <none>        6379/TCP         2d20h
reverse-proxy           NodePort    10.236.12.38    <none>        8080:31000/TCP   2d20h
```

check on browser
http://35.240.10.47:31000/
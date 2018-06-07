
docker run --name some-mysql -d -e MYSQL_ROOT_PASSWORD=root mysql 

docker run \
    -e MYSQL_USER=root \
    -e MYSQL_PASSWORD=root \
    -e MYSQL_HOST=mysql \
    -e MYSQL_PORT=3306 \
    -e MYSQL_DB=wordpress \
    --link some-mysql:mysql \
    -it eu.gcr.io/sandbox-wescale/my-prom-mysql:master-v4 
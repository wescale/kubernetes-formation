#!/bin/ash

until nc -w5 127.0.0.1 3306
do
  sleep 0.5
  echo "Wait for MySQL"
done
sleep 1

export DATA_SOURCE_NAME=$MYSQL_USER:$MYSQL_PASSWORD@($MYSQL_HOST:$MYSQL_PORT)/$MYSQL_DB

/bin/mysqld_exporter


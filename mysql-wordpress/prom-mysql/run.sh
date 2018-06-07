#!/bin/ash

until nc -w5 $MYSQL_HOST 3306
do
  sleep 0.5
  echo "Wait for MySQL"
done
sleep 1

echo "end"
export DATA_SOURCE_NAME="$MYSQL_USER:$MYSQL_PASSWORD@($MYSQL_HOST:$MYSQL_PORT)/$MYSQL_DB"
echo $DATA_SOURCE_NAME

/bin/mysqld_exporter


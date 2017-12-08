#!/bin/ash

until nc -w5 127.0.0.1 3306
do
  sleep 0.5
  echo "Wait for MySQL"
done
sleep 1

/bin/mysqld_exporter


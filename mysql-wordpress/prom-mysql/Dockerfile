FROM prom/mysqld-exporter:master

ENV MYSQL_USER root
ENV MYSQL_PASSWORD root
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DB wordpress

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT  [ "/run.sh" ]

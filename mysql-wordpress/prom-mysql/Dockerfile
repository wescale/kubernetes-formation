FROM prom/mysqld-exporter:master

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT  [ "/run.sh" ]

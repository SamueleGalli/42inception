FROM debian:bullseye

RUN apt-get update -y && apt-get install -y mariadb-server \
    && sed -i 's/^binf-adress/#&/' /etc/mysql/mariadb.conf.d/50-server.cnf \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY mariadb.sh /

RUN chmod +x /mariadb.sh

VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

CMD ["/mariadb.sh"]
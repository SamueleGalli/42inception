FROM debian:bullseye

RUN apt-get update -y && apt-get install -y mariadb mariadb-client \
COPY mariadb.sh /

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools ./tools

RUN chmod +x ./tools/setup.sh

CMD [ "./tools/setup.sh" ]
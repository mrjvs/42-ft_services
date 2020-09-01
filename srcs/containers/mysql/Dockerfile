FROM alpine:latest

WORKDIR /app
VOLUME /app

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

COPY mysqld.conf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 0444 /etc/my.cnf.d/mariadb-server.cnf

COPY entrypoint.sh /entrypoint.sh

EXPOSE 3306
CMD /entrypoint.sh

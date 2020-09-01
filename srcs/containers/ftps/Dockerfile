FROM alpine:3.12.0
WORKDIR /usr/share/ftps

# update
RUN apk update

# install dependencies and vsftpd
RUN apk add vsftpd openssl

# cert generation
RUN mkdir -p /etc/ssl/keys && \
    mkdir -p /etc/ssl/certs && \
    openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/keys/localhost.key -out /etc/ssl/certs/localhost.pem -days 365 -subj "/C=NL/ST=North Holland/L=Amsterdam/O=Codam/OU=Codam/CN=localhost" -nodes

# copy config
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

# copy entrypoint
COPY entrypoint.sh /etc/vsftpd/entrypoint.sh

# expose ports
# ftp - ftps - passive port 1 - passive port 2
EXPOSE 21 990 21000 21001

# setup volumes
VOLUME /usr/share/ftps

# set entrypoint
ENTRYPOINT /etc/vsftpd/entrypoint.sh

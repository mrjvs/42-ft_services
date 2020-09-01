FROM alpine:3.12.0

WORKDIR /usr/share/nginx

# copy entrypoint
COPY ./entrypoint.sh /usr/share/nginx
COPY supervisord.conf /etc/supervisord.conf
COPY stop-supervisord.sh /etc/stop-supervisord.sh

# update registry
RUN apk update

# install dependencies
RUN apk add openssl supervisor

# install ssh server
RUN apk add --no-cache openssh
RUN /usr/bin/ssh-keygen -A
RUN echo "AllowUsers root" >> /etc/ssh/sshd_config && \
    echo "PrintMotd no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# install nginx
RUN apk add nginx
RUN mkdir -p /run/nginx

# cert generation
RUN mkdir -p /etc/nginx/keys && \
    mkdir -p /etc/nginx/certs && \
    openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/keys/localhost.key -out /etc/nginx/certs/localhost.pem -days 365 -subj "/C=NL/ST=North Holland/L=Amsterdam/O=Codam/OU=Codam/CN=localhost" -nodes

# copy nginx configuration
COPY ./site-config.conf /etc/nginx/conf.d/default.conf

# copy site files
COPY ./www /usr/share/nginx/www

# expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 22

# start services
ENTRYPOINT sh entrypoint.sh

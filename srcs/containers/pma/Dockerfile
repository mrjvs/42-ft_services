FROM alpine:3.12.0
WORKDIR /var/www

# update packages
RUN apk update

# install lighttpd and php with modules
RUN apk add supervisor
RUN apk add lighttpd
RUN apk add \
    php-common \
    php-session \
    php-fpm \
    php-dom \
    php-xml \
    php-xmlreader \
    php-curl \
    php-exif \
    php-ftp \
    php-gd \
    php-iconv \
    php-json \
    php-mbstring \
    php-mysqli \
    php-openssl \
    php-posix \
    php-sockets \
    php-tokenizer \
    php-zlib \
    php-exif

# copy config
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

# install phpmyadmin
RUN mkdir ./tmp && cd ./tmp && wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz && tar -zxvf phpMyAdmin-4.9.5-all-languages.tar.gz
RUN mv ./tmp/phpMyAdmin-4.9.5-all-languages ./phpmyadmin && rm -rf ./tmp

# set permissions
RUN chown -R lighttpd:lighttpd ./phpmyadmin && chmod -R 755 ./phpmyadmin

# entrypoint
COPY entrypoint.sh /entrypoint.sh
COPY supervisord.conf /etc/supervisord.conf
COPY stop-supervisord.sh /etc/stop-supervisord.sh

# ports
EXPOSE 80

# start php fpm and
ENTRYPOINT /entrypoint.sh

FROM alpine:3.12.0
WORKDIR /var/www

# update packages
RUN apk update

# install lighttpd and php with modules
RUN apk add supervisor curl mysql-client
RUN apk add lighttpd
RUN apk add \
    php-common \
    php-fpm \
    php-phar \
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
    php-exif \
    php7

# install wordpress cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# copy entrypoint
COPY entrypoint.sh /entrypoint.sh
COPY supervisord.conf /etc/supervisord.conf
COPY stop-supervisord.sh /etc/stop-supervisord.sh

# copy config
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf
RUN sed -i "s/post_max_size = .M/post_max_size = 250M/ ; s/upload_max_filesize = .M/upload_max_filesize = 250M/" /etc/php7/php.ini

# ports
EXPOSE 5050
VOLUME ["/var/www"]

# start php fpm and
ENTRYPOINT /entrypoint.sh

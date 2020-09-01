# download wordpress
if [ ! -d "/var/www/wordpress" ]; then
    mkdir -p /var/www/tmp
    cd /var/www/tmp
    wget https://wordpress.org/latest.tar.gz && tar -zxvf latest.tar.gz
    mv /var/www/tmp/wordpress /var/www && rm -rf /var/www/tmp
    chown -R lighttpd:lighttpd /var/www/wordpress && chmod -R 755 /var/www/wordpress
fi

cd /var/www/wordpress

# first boot
if [ -f "/var/www/wordpress/wp-admin/install.php" ]; then
    echo "install script present, installing wordpress"

    # creating config
    wp config create --dbname="$MYSQL_DB" --dbhost="$MYSQL_HOST" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASS" --allow-root
    wp core install --url="http://$WP_ROOT:5050" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email="$WP_EMAIL" --allow-root

    # creating users
    # syntax
    # user:
    #   <username>,<email>,<password>
    #
    # user list:
    #   <user>;<user>;...
    for i in $(echo $USERS | tr ";" "\n"); do
        USERNAME=$(echo $i | cut -d',' -f 1)
        EMAIL=$(echo $i | cut -d',' -f 2)
        PASS=$(echo $i | cut -d',' -f 3)

        wp user create "$USERNAME" "$EMAIL" --user_pass="$PASS" --allow-root
    done

    # update siteurl
    wp option update siteurl "http://$WP_ROOT:5050" --allow-root
    wp option update home "http://$WP_ROOT:5050" --allow-root
fi

cd /etc
exec supervisord -c /etc/supervisord.conf

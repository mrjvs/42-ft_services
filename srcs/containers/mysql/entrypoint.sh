# make socket, blame alpine
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
fi

# run install script if first run
if [ ! -d "/app/mysql" ]; then

# installing mysql
echo "Data directory not found, creating!"
mysql_install_db --user=root

# mysql secure install
cat > /tmpfile << EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
EOF

# set root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /tmpfile

# make databases and stuff
echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE_NAME\`;" >> /tmpfile
echo "GRANT ALL ON \`$MYSQL_DATABASE_NAME\`.* to '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /tmpfile
echo "FLUSH PRIVILEGES;" >> /tmpfile

cat /tmpfile

# execute all the queries
/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmpfile
rm -f /tmpfile

fi

# startup sql server
exec /usr/bin/mysqld --user=root --console

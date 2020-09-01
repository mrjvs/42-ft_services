echo "root:$ROOT_PASSWORD" | chpasswd

cd /etc
exec supervisord -c /etc/supervisord.conf

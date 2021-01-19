BLOWFISH_SECRET="hello"
PMA_HOST="${PMA_HOST:="localhost"}"

echo "<?php" > /tmpfile
echo "\$cfg['blowfish_secret'] = '$BLOWFISH_SECRET';" >> /tmpfile
echo "\$cfg['Servers'][1]['auth_type'] = 'cookie';" >> /tmpfile
echo "\$cfg['Servers'][1]['host'] = '$PMA_HOST';" >> /tmpfile
echo "\$cfg['Servers'][1]['compress'] = false;" >> /tmpfile
echo "\$cfg['Servers'][1]['AllowNoPassword'] = false;" >> /tmpfile
echo "?>" >> /tmpfile

mv /tmpfile /var/www/phpmyadmin/config.inc.php
chown lighttpd:lighttpd /var/www/phpmyadmin/config.inc.php
chmod +x /var/www/phpmyadmin/config.inc.php

cd /etc
exec supervisord -c /etc/supervisord.conf

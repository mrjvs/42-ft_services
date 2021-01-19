# error out if password not set
if [ -z "$PASSWORD" ]; then
  echo "Password not set"
  exit 1
fi

# set username if not set
if [ -z "$USERNAME" ]; then
  USERNAME=ftpuser
fi

mkdir -p /usr/share/ftps/data
deluser $USERNAME

# make new user with username and password
echo -e "$PASSWORD\n$PASSWORD" | adduser -h /usr/share/ftps/data $USERNAME

# set folder owner
chown $USERNAME:$USERNAME /usr/share/ftps/data

# wait for ip to be set
echo "User setup done"
echo "-----"
echo "Waiting for ip!"
while [ ! -f "/usr/share/ftps/ip" ]; do
  sleep 10
done;

# set ip
IP=$(cat /usr/share/ftps/ip)
sed -i -e "s=IPHERE=$IP=g" /etc/vsftpd/vsftpd.conf

echo "ip has been set"

# run ftp server with config
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

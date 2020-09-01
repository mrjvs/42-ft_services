sed -i -e "s=INFLUX_DB_URL=http://$DB_HOSTNAME:$DB_PORT=g" /etc/telegraf/telegraf.conf
sed -i -e "s=KUBELET_URL=https://kubernetes.default.svc.cluster.local/api/v1/nodes/$NODE_NAME/proxy=g" /etc/telegraf/telegraf.conf
exec telegraf

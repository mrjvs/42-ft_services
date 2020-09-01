grafana-cli --homepath "/grafana" admin reset-admin-password $ADMIN_PASSWORD

mkdir -p /var/lib/grafana/dashboards

# pod description:
#   <display name>,<pod name>,<file name>
#
# pod list:
#   <pod description>;<pod description>;...
for i in $(echo $PODS | tr ";" "\n"); do
    NAME=$(echo $i | cut -d',' -f 1)
    PODNAME=$(echo $i | cut -d',' -f 2)
    FILE=$(echo $i | cut -d',' -f 3)

    FILEPATH="/var/lib/grafana/dashboards/$FILE.json"

    cp ./templates/dashboard.json $FILEPATH

    sed -i -e "s=PODNAMEHERE=$PODNAME=g" $FILEPATH
    sed -i -e "s=PODSEMANTICNAME=$NAME=g" $FILEPATH
done

sed -i -e "s=INFLUXDB_HOST=$INFLUXDB_HOST=g" /grafana/conf/provisioning/datasources/sample.yaml
sed -i -e "s=INFLUXDB_PORT=$INFLUXDB_PORT=g" /grafana/conf/provisioning/datasources/sample.yaml

exec grafana-server --homepath=/grafana

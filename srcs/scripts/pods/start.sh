# volumes
kubectl apply -f ../config/volumes.yml

# services
kubectl apply -f ../config/nginx.yml
kubectl apply -f ../config/ftps.yml
kubectl apply -f ../config/wordpress.yml
kubectl apply -f ../config/mysql.yml
kubectl apply -f ../config/pma.yml
kubectl apply -f ../config/influx.yml
kubectl apply -f ../config/telegraf.yml
kubectl apply -f ../config/grafana.yml

# setup wordpress siteurl
STAT=$(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}')
while [[ -z $STAT || $STAT == "<pending>" ]]; do
    sleep 10
    echo "Rechecking wordpress ip"
    STAT=$(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}')
    echo "$STAT"
done;
echo "found wordpress ip, setting url! ";
while [[ $(kubectl exec $(kubectl get pods | grep "^wordpress" | awk 'NR == 1 {print $1}') -- sh -c "wp option update siteurl 'http://$STAT:5050' --path='/var/www/wordpress' --allow-root" > /dev/null; echo $?) != "0" ]]; do
    echo "Failed to set url, retrying in 10 ";
    sleep 10
done;
STAT=$(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}')
kubectl exec $(kubectl get pods | grep "^wordpress" | awk 'NR == 1 {print $1}') -- sh -c "wp option update home 'http://$STAT:5050' --path='/var/www/wordpress' --allow-root"
kubectl exec $(kubectl get pods | grep "^wordpress" | awk 'NR == 1 {print $1}') -- sh -c "wp option update siteurl 'http://$STAT:5050' --path='/var/www/wordpress' --allow-root"
echo "Set wordpress url successfully! ";

# setup ftps ip
STAT=$(kubectl get services | grep "^ftps" | awk 'NR == 1 {print $4}')
while [[ -z $STAT || $STAT == "<pending>" ]]; do
    sleep 10
    echo "Rechecking ftps ip"
    STAT=$(kubectl get services | grep "^ftps" | awk 'NR == 1 {print $4}')
    echo "$STAT"
done;
echo "found ftps ip, setting ip! ";
while [[ $(kubectl exec $(kubectl get pods | grep "^ftps" | awk 'NR == 1 {print $1}') -- sh -c "echo $STAT > /usr/share/ftps/ip" > /dev/null; echo $?) != "0" ]]; do
    echo "Failed to set ftps ip, retrying in 10 ";
    sleep 10
done;
echo "Set ftps ip successfully! ";
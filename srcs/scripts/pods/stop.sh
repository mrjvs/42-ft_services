# services
kubectl delete -f ../config/nginx.yml
kubectl delete -f ../config/ftps.yml
kubectl delete -f ../config/wordpress.yml
kubectl delete -f ../config/mysql.yml
kubectl delete -f ../config/pma.yml
kubectl delete -f ../config/influx.yml
kubectl delete -f ../config/telegraf.yml
kubectl delete -f ../config/grafana.yml

# volumes
kubectl delete -f ../config/volumes.yml

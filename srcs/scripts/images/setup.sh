# metallb
# ./extra/build.sh metallb/controller metallb-controller
# ./extra/build.sh metallb/speaker metallb-speaker

# secrets
kubectl create secret generic passwords --from-literal=root=helloworld # root pass for ftp and ssh
kubectl create secret generic wpsalt --from-literal=wpsalt=helloworld # wordpress salt
kubectl create secret generic pmablowfish --from-literal=blowfish=helloworld # phpmyadmin blowfish
kubectl create secret generic wppass --from-literal=wppass=helloworld # wordpress admin pass
kubectl create secret generic wpsqlpass --from-literal=wpsqlpass=helloworld # wordpress mysql pass
kubectl create secret generic grafana --from-literal=admin=helloworld # grafana admin pass

# nginx
./extra/build.sh nginx nginx

# ftps
./extra/build.sh ftps ftps

# wordpress
./extra/build.sh wordpress wordpress

# mysql
./extra/build.sh mysql mysql

# phpmyadmin
./extra/build.sh pma pma

# telegraf
./extra/build.sh telegraf telegraf

# influxdb
./extra/build.sh influx influx

# grafana
./extra/build.sh grafana grafana

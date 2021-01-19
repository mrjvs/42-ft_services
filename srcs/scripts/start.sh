if [[ $(minikube status | grep -c "Running") == 0 ]]
then
printf "\e[32;1m--- (0/2) STARTING MINIKUBE ---\e[0m\n"
minikube start --vm-driver=virtualbox
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb

kubectl delete configmap -n metallb-system config
cat ../config/config-template.yml | sed -e "s=IPHERE=$(minikube ip)-$(minikube ip | sed -En 's=(([0-9]+\.){3})[0-9]+=\1255=p')=" | kubectl apply -f -
else
printf "\e[32;1m--- (0/2) MINIKUBE IS RUNNING ---\e[0m\n"
fi

# setup minikube env - I dislike this solution
eval $(minikube docker-env)

printf "\e[32;1m--- (1/2) BUILDING OF IMAGES ---\e[0m\n"
./images/setup.sh

printf "\e[32;1m--- (2/2) STARTING SERVICES ---\e[0m\n"
./pods/start.sh

printf "\e[32;1m--- STARTED FT_SERVICES ---\e[0m\n"
printf "\e[32;1mdone :)\e[0m\n"

printf "\n\e[90mRunning on \e[32;1m$(minikube ip)\e[0m\n"

# waiting for ip's to be assigned
STAT=$(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}')
while [[ -z $STAT || $STAT == "<none>" ]]; do
    sleep 3
    STAT=$(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}')
done;

printf "\e[90mServices running:\e[0m\n"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "FTP" $(kubectl get services | grep "^ftps" | awk 'NR == 1 {print $4}') "21"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "SSH" $(kubectl get services | grep "^nginx" | awk 'NR == 1 {print $4}') "22"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "Wordpress" $(kubectl get services | grep "^wordpress" | awk 'NR == 1 {print $4}') "5050"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "PHPMyAdmin" $(kubectl get services | grep "^pma" | awk 'NR == 1 {print $4}') "5000"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "Grafana" $(kubectl get services | grep "^grafana" | awk 'NR == 1 {print $4}') "3000"
printf "\e[32;1m✓ \e[0m %-11s\e[32;1m%s %s\e[0m\n" "Nginx" $(kubectl get services | grep "^nginx" | awk 'NR == 1 {print $4}') "80, 443"

# incorrect way to use k8s

todo:
 - [X] metallb
 - [X] ftps
 - [X] grafana
 - [X] nginx + shh
 - [X] mysql
 - [X] wordpress
 - [X] phpmyadmin
 - [X] influx
 - [X] k8s dashboard (`minikube addons enable dashboard`)
 - [X] phpmyadmin user install
 - [X] wordpress install
 - [X] use process manager (wordpress, phpmyadmin, nginx+ssh)

before turnin:
 - [X] properly do secrets
 - [X] change 302 to 301
 - [X] test database crashes -> no data loss
 - [X] test restart policy
 - [X] change upload limit in php
 - [X] make telegraf listen correctly
 - [X] fix ftp crash on conenction close
 - [X] remove `ls -la` from go builds
 - [X] fix wordpress (setup install step 2, site health)
 - [X] make stuff work with minikube
 - [X] setup minikube to work with registry (and depricate the registry)
 - [X] Add more users to wordpress
 - [X] fix printf issues

weird things:
 - ftps uses 4 ports. not only 21
 - certs are self signed (nginx/ftps)

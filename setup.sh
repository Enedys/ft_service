#!/bin/sh#
export MINIKUBE_HOME=/Users/kwillum/goinfre/.minikube ;
export PATH=$MINIKUBE_HOME/bin:$PATH ;
export KUBECONFIG=$MINIKUBE_HOME/.kube/config ;
export KUBE_EDITOR="code -w" ;

minikube start --driver=virtualbox --disk-size=5000MB;
minikube addons enable metallb;
minikube addons enable dashboard;

eval $(minikube -p minikube docker-env) ;
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml ;
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml ;
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" ;
kubectl apply -f ./srcs/metallb/metallb.yaml ;

docker build -t mysql-image ./srcs/mysql > /dev/null ;
docker build -t phpmyadmin-image ./srcs/phpmyadmin > /dev/null ;
docker build -t influxdb-image ./srcs/influxdb ;
docker build -t telegraf-image ./srcs/telegraf ;

kubectl apply -f ./srcs/mysql/mysql-deployment.yaml ;

kubectl apply -f ./srcs/wordpress/wordpress-service.yaml ;
sleep 2
WP_IP=$(kubectl get svc wordpress-service -o=custom-columns='DATA:status.loadBalancer.ingress' | sed -n 2p | cut -d ":" -f2 | tr -d "]") ;
echo "${WP_IP}" ;
docker build -t wordpress-image --build-arg IP=${WP_IP} ./srcs/wordpress ;
kubectl apply -f ./srcs/wordpress/wordpress-deployment.yaml ;

kubectl apply -f ./srcs/ftps/ftps-service.yaml ;
FTP_IP=$(kubectl get svc ftps-service -o=custom-columns='DATA:status.loadBalancer.ingress' | sed -n 2p | cut -d ":" -f2 | tr -d "]") ;
echo "${FTP_IP}" ;
docker build -t ftps-image --build-arg IP=${FTP_IP} ./srcs/ftps > /dev/null;
kubectl apply -f ./srcs/ftps/ftps-deployment.yaml ;

kubectl apply -f ./srcs/nginx/nginx-service.yaml ;
N_IP=$(kubectl get svc nginx-service -o=custom-columns='DATA:status.loadBalancer.ingress' | sed -n 2p | cut -d ":" -f2 | tr -d "]") ;
echo "${N_IP}" ;
docker build -t nginx-image --build-arg IP=${N_IP} ./srcs/nginx > /dev/null ;
kubectl apply -f ./srcs/nginx/nginx-deployment.yaml ;


kubectl apply -f ./srcs/phpmyadmin/phpmyadmin-deployment.yaml ;

kubectl apply -f ./srcs/influxdb/influxdb-service.yaml ;
kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml ;
kubectl apply -f ./srcs/influxdb/influxdb-conf.yaml ;
kubectl apply -f ./srcs/influxdb/influxdb-secret.yaml ;
kubectl apply -f ./srcs/influxdb/influxdb-deployment.yaml ;

kubectl apply -f ./srcs/telegraf/telegraf-conf.yaml ;
kubectl apply -f ./srcs/telegraf/telegraf-secret.yaml ;
kubectl apply -f ./srcs/telegraf/telegraf-deployment.yaml ;

docker build -t grafana-image ./srcs/grafana ;
kubectl apply -f ./srcs/grafana/grafana-conf.yaml ;
kubectl apply -f ./srcs/grafana/grafana-secret.yaml ;
kubectl apply -f ./srcs/grafana/grafana-deployment.yaml ;

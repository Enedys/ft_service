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
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)";
kubectl apply -f ./metallb/metallb.yaml;

docker build -t nginx-image ./nginx > /dev/null;
docker build -t mysql-image ./mysql > /dev/null;
docker build -t phpmyadmin-image ./phpmyadmin > /dev/null;
kubectl apply -f ./mysql/mysql-deployment.yaml ;

kubectl apply -f ./wordpress/wordpress-service.yaml
WP_IP=$(kubectl get svc wordpress-service -o=custom-columns='DATA:status.loadBalancer.ingress' | sed -n 2p | cut -d ":" -f2 | tr -d "]")
echo "${WP_IP}"
docker build -t wordpress-image --build-arg IP=${WP_IP} ./wordpress ;
kubectl apply -f ./wordpress/wordpress-deployment.yaml

kubectl apply -f ./ftps/ftps-service.yaml ;
FTP_IP=$(kubectl get svc ftps-service -o=custom-columns='DATA:status.loadBalancer.ingress' | sed -n 2p | cut -d ":" -f2 | tr -d "]")
echo "${FTP_IP}"
docker build -t ftps-image --build-arg IP=${FTP_IP} ./ftps > /dev/null;
kubectl apply -f ./ftps/ftps-deployment.yaml ;


kubectl apply -f ./nginx/nginx-deployment.yaml ;
kubectl apply -f ./wordpress/wordpress-deployment.yaml ;
kubectl apply -f ./phpmyadmin/phpmyadmin-deployment.yaml ;

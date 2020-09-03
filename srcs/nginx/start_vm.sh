#!/bin/sh#
export MINIKUBE_HOME=/Users/kwillum/goinfre/.minikube ;
export PATH=$MINIKUBE_HOME/bin:$PATH ;
export KUBECONFIG=$MINIKUBE_HOME/.kube/config ;
export KUBE_EDITOR="code -w" ;

minikube start --driver=virtualbox --disk-size=3000MB;
minikube addons enable metallb;
minikube addons enable dashboard;

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml ;
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml ;
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)";
kubectl apply -f ../metallb/metallb.yaml;

docker build -t nginx-image . ;
eval $(minikube -p minikube docker-env) ;
kubectl apply -f nginx-deployment.yaml ;

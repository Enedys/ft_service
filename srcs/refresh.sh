#!/bin/bash
export MINIKUBE_HOME=/Users/kwillum/goinfre/.minikube ;
export PATH=$MINIKUBE_HOME/bin:$PATH ;
export KUBECONFIG=$MINIKUBE_HOME/.kube/config ;
export KUBE_EDITOR="code -w" ;
eval $(minikube -p minikube docker-env) ;
kubectl delete deploy ftps-deployment  ;
docker build -t ftps-image ./ftps > /dev/null;
kubectl apply -f ./ftps/ftps-deployment.yaml ;
kubectl get pods  ;

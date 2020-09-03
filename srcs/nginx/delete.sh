#!/bin/sh

kubectl delete deployment nginx-deployment ;
kubectl delete svc service-nginx ;
kubectl get pods  -o wide ;
kubectl get svc -o wide ;
minikube service list ;

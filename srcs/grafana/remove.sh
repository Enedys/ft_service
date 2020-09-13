#!/bin/bash

kubectl delete configmaps grafana-config  ;
kubectl delete svc grafana-service      ;
kubectl delete deployment  grafana-deployment ;
kubectl delete secret grafana-secret ;
#!/bin/sh

kubectl create configmap influxdb-conf.yaml --from-file=influxdb.conf ;
kubectl get configmaps influxdb-conf.yaml  -o yaml > influxdb-conf.yaml ;

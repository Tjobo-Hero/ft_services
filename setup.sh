#!/bin/bash

# COLORS FOR ECHO #
GREEN='\x1b[32m'
END='\x1b[0m'
BLINK='\x1b[5m'

#STOP OTHER RUNNING PROCESSES#
minikube stop
minikube delete

# REMOVE OLD MINIKUBE AND LINKING TO GOINFRE #
rm -rf ~/.minikube
mkdir -p ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube

# STARTING UP KUBERNETES #
echo -e "${GREEN}SETTING UP MINIKUBE${END}"
minikube start --driver=virtualbox

# ACTIVATING ADDONS #
echo -e "${GREEN}Activating addons...${END}"
minikube addons enable metallb
minikube addons enable dashboard

# CREATING SECRT METALLB #
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb_config.yaml

# SETTING UP LOCAL IMAGE #
echo -e "${GREEN}SETTING UP LOCAL IMAGE${END}"
eval $(minikube docker-env)

# GETTING IP LOCAL IMAGE #
IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo -e "${GREEN}IP:${IP}${END}"

# NGINX # 
echo -e "${GREEN}START NGINX IMAGE BUILD${END}"
docker build -t nginx ./srcs/nginx
echo -e "${GREEN}START NGINX DEPLOYMENT${END}"
kubectl apply -f srcs/nginx/nginx.yaml

# SERVICE ACCOUNT # 
echo -e "${GREEN}CREATE SERVICE ACCOUNT${END}"
kubectl create serviceaccount tvan-cit
echo -e "${GREEN}START SERVIE ACCOUNT DEPLOYMENT${END}"
kubectl apply -f srcs/account/serviceaccount.yaml

# FTPS #
echo -e "${GREEN}START FTPS IMAGE BUILD${END}"
docker build -t ftps ./srcs/ftps
echo -e "${GREEN}START FTPS DEPLOYMENT${END}"
kubectl apply -f srcs/ftps/ftps.yaml

# MYSQL #
echo -e "${GREEN}START MYSQL IMAGE BUILD${END}"
docker build -t mysql ./srcs/mysql
echo -e "${GREEN}START MYSQL DEPLOYMENT${END}"
kubectl apply -f srcs/mysql/mysql.yaml

# PHP MYADMIN # 
echo -e "${GREEN}START PHPMYADMIN IMAGE BUILD${END}"
docker build -t phpmyadmin ./srcs/phpmyadmin
echo -e "${GREEN}START PHPMYADMIN DEPLOYMENT${END}"
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml

# WORDPRESS #
echo -e "${GREEN}START WORDPRESS IMAGE BUILD${END}"
docker build -t wordpress ./srcs/wordpress
echo -e "${GREEN}START WORDPRESS DEPLOYMENT${END}"
kubectl apply -f srcs/wordpress/wordpress.yaml

# INFLUX DB #
echo -e "${GREEN}START INFLUX DB IMAGE BUILD${END}"
docker build -t influxdb ./srcs/influxdb
echo -e "${GREEN}START INFLUX DB DEPLOYMENT${END}"
kubectl apply -f srcs/influxdb/influxdb.yaml

# TELEGRAF #
echo -e "${GREEN}START TELEGRAF IMAGE BUILD${END}"
docker build -t telegraf ./srcs/telegraf
echo -e "${GREEN}START TELEGRAF DEPLOYMENT${END}"
kubectl apply -f srcs/telegraf/telegraf.yaml

# GRAFANA # 
echo -e "${GREEN}START GRAFANA IMAGE BUILD${END}"
docker build -t grafana ./srcs/grafana
echo -e "${GREEN}START GRAFANA DEPLOYMENT${END}"
kubectl apply -f srcs/grafana/grafana.yaml

# NAMESPACE=grafana
# POD_NAME=$(kubectl get pods  -o=name "${NAMESPACE}" | grep grafana | cut -f2 -d\/)
# kubectl exec -it "${NAMESPACE}" "${POD_NAME}" -- /bin/sh -c "/usr/share/grafana/bin/grafana-cli admin reset-admin-password ${POD_NAME}"

echo -e "${GREEN}START >>>>IMAGE BUILD COMPLETED<<<<${END}"
echo -e "${GREEN}START >>>>DEPLOYMENT COMPLETED<<<<${END}"


# GETTING IP LOCAL IMAGE #
IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
echo -e "${GREEN}IP:${IP}${END}"

echo -e "${GREEN}START LAUNCH KUBERNETES DASHBOARD${END}"
minikube dashboard

#!/bin/zsh

minikube delete
# rm -rf ~/.minikube
# rm -rf ~/goinfre/.minikube
# mkdir ~/goinfre/.minikube
# ln -s ~/.minikube ~/goinfre/.minikube

minikube start --driver=virtualbox
minikube addons enable metallb
minikube addons enable dashboard

# minikube start --driver=virtualbox \
#                 --cpus=2 --memory=2048 --disk-size=10g \
#                 --addons metallb \
#                 --addons dashboard 
# minikube addons enable metallb 
# minikube addons enable dashboard

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb_config.yaml

eval $(minikube docker-env)

docker build -t nginx ./srcs/nginx
kubectl apply -f srcs/nginx/nginx.yaml

kubectl create serviceaccount wester
kubectl apply -f srcs/account/serviceaccount.yaml

docker build -t ftps ./srcs/ftps
kubectl apply -f srcs/ftps/ftps.yaml

docker build -t mysql ./srcs/mysql
kubectl apply -f srcs/mysql/mysql.yaml

docker build -t phpmyadmin ./srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml

docker build -t wordpress ./srcs/wordpress
kubectl apply -f srcs/wordpress/wordpress.yaml

docker build -t influxdb ./srcs/influxdb
kubectl apply -f srcs/influxdb/influxdb.yaml

docker build -t telegraf ./srcs/telegraf
kubectl apply -f srcs/telegraf/telegraf.yaml

docker build -t grafana ./srcs/grafana
kubectl apply -f srcs/grafana/grafana.yaml

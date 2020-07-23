# COLORS FOR ECHO #
GREEN='\x1b[32m'
END='\x1b[0m'
BLINK='\x1b[5m'

# REMOVE OLD MINIKUBE AND LINKING TO GOINFRE #
rm -rf ~/.minikube
mkdir -p ~/goinfre/minikube
ln -s ~/goinfre/minikube ~/.minikube

# STARTING UP KUBERNETES #
echo -e "${GREEN}SETTING UP MINIKUBE${END}"
minikube --vm-driver=virtualbox start --extra-config=apiserver.service-node-port-range=1-35000

echo -e "${GREEN}Activating addons...${END}"
minikube addons enable ingress
minikube addons enable dashboard

echo -e "${GREEN}LAUNCH KUBERNETES DASHBOARD${END}"
minikube dashboard &

echo -e "${GREEN}EVAL COMMAND${END}"
eval $(minikube docker-env)

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
# IP=$(minikube ip)
echo -e "${GREEN}IP:${IP}${END}"

echo -e "${GREEN}BUILDING IMAGES${END}"
docker build -t nginx_image ./srcs/containers/nginx
# docker build -t service_test ./srcs/containers/test
docker build -t ftps_image ./srcs/containers/ftps
docker build -t mysql_image ./srcs/containers/mysql --build-arg IP=${IP}
docker build -t wordpress_image ./srcs/containers/wordpress --build-arg IP=${IP}
docker build -t phpmyadmin_image ./srcs/containers/phpmyadmin --build-arg IP=${IP}
docker build -t influxdb_image ./srcs/containers/influxdb
docker build -t grafana_image ./srcs/containers/grafana
docker build -t telegraf_image  ./srcs/containers/telegraf

echo -e "${GREEN}CREATING SERVICE WITH YAML FILES${END}"
# kubectl delete validatingwebhookconfiguration ingress-nginx-admission
kubectl create -f ./srcs/yaml
# kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
# kubectl expose deployment web --type=NodePort --port=8080

echo -e "${GREEN}LAUNCHING SUPER AWESOME WEBSITE"
open http://${IP}

### Dashboard
# minikube dashboard

###
# ssh admin@$(minikube ip) -p 4321

### Crash Container
# kubectl exec -it $(kubectl get pods | grep mysql | cut -d" " -f1) -- /bin/sh -c "ps"  
# kubectl exec -it $(kubectl get pods | grep mysql | cut -d" " -f1) -- /bin/sh -c "kill number"
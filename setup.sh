# export MINIKUBE_HOME=~/goinfre
# minikube start --driver=virtualbox
# echo "대쉬보드 설치"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# echo "대쉬보드 접근 토큰 생성"
# kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
# minikube를 사용하지 않는 경우에 위의 방법을 사용하여 대쉬보드를 설치할 수 있다.
# 그 후 kubectl proxy 라고 커맨드라인 창에 입력하고 발급된 토큰을 사용하여 대쉬보드에 접속한다.
# minikube를 사용하는 경우에는 단순하게 minikube dashboard 라고 커맨드라인 창에 입력하면 된다.

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

echo -e "${GREEN}SETTING UP LOCAL IMAGE${END}"
eval $(minikube docker-env)

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
# IP=$(minikube ip)
echo -e "${GREEN}IP:${IP}${END}"

echo -e "${GREEN}SETTING UP METALLB${END}"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb-config.yaml

sleep 10

# # echo "local image 사용가능하게 하기"
# eval $(minikube docker-env)

cd ./srcs/
echo -e "${GREEN}>>>>BUIDLING IMAGES<<<<${END}"
echo -e "${GREEN}MYSQL IMAGE BUILD${END}"
docker build -t service-mysql ./mysql > /dev/null
echo -e "${GREEN}WORDPRESS IMAGE BUILD${END}"
docker build -t service-wordpress ./wordpress > /dev/null
echo -e "${GREEN}PHPMYADMIN IMAGE BUILD${END}"
docker build -t service-phpmyadmin ./phpmyadmin > /dev/null
echo -e "${GREEN}NGINX IMAGE BUILD${END}"
docker build -t service-nginx ./nginx > /dev/null
echo -e "${GREEN}FTPS IMAGE BUILD${END}"
docker build -t service-ftps ./ftps > /dev/null
echo -e "${GREEN}TELEGRAF IMAGE BUILD${END}"
docker build -t service-telegraf ./telegraf > /dev/null
echo -e "${GREEN}INFLUX DB IMAGE BUILD${END}"
docker build -t service-influxdb ./influxdb > /dev/null
echo -e "${GREEN}GRAFANA IMAGE BUILD${END}"
docker build -t service-grafana ./grafana > /dev/null
echo -e "${GREEN}>>>>IMAGE BUILD COMPLETED<<<<${END}"

sleep 5

echo -e "${GREEN}>>>>STARTING DEPLOYMENT<<<<${END}"
echo -e "${GREEN}MYSQL DEPLOYMENT${END}"
kubectl apply -f ./mysql/mysql.yaml > /dev/null
echo -e "${GREEN}WORDPRESS DEPLOYMENT${END}"
kubectl apply -f ./wordpress/wordpress.yaml > /dev/null
echo -e "${GREEN}PHPMYADMIN DEPLOYMENT${END}"
kubectl apply -f ./phpmyadmin/phpmyadmin.yaml > /dev/null
echo -e "${GREEN}NGINX SSL SECRET${END}"
kubectl apply -f ./nginx/nginxsecret.yaml > /dev/null
echo -e "${GREEN}NGINX CONFIG MAP${END}"
kubectl create configmap nginxconfigmap --from-file=./nginx/default.conf --from-file=./nginx/proxy.conf > /dev/null
echo -e "${GREEN}NGINX DEPLOYMENT${END}"
kubectl apply -f ./nginx/nginx.yaml > /dev/null
echo -e "${GREEN}FTPS DEPLOYMENT${END}"
kubectl apply -f ./ftps/ftps.yaml > /dev/null
echo -e "${GREEN}INFLUX DB DEPLOYMENT${END}"
kubectl apply -f ./influxdb/influxdbconf.yaml > /dev/null
kubectl apply -f ./influxdb/influxdb.yaml > /dev/null
echo -e "${GREEN}TELEGRAF DEPLOYMENT${END}"
kubectl apply -f ./telegraf/telegrafconf.yaml > /dev/null
kubectl apply -f ./telegraf/telegraf.yaml > /dev/null
echo -e "${GREEN}GRAFANA DEPLOYMENT${END}"
kubectl apply -f ./grafana/grafana.yaml > /dev/null
echo -e "${GREEN}>>>>DEPLOYMENT COMPLETED<<<<${END}"

# minikube addons enable metrics-server

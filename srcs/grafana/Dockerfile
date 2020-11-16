# Grafana is a open source analytics & monitoring solution for every database.

# building from Alpine Linux
FROM alpine:3.12

# updating the packagelist and installing the necessary packages
RUN apk update && \
	apk add vim wget curl libc6-compat

# download and unpack grafana
RUN wget https://dl.grafana.com/oss/release/grafana-7.2.0.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.2.0.linux-amd64.tar.gz

COPY default.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY *.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY default.yaml /usr/share/grafana/conf/provisioning/dashboards/

# copy grafana.db to the correct location
COPY ./grafana.db ./grafana-7.2.0/data/grafana.db

# Open port
EXPOSE 3000

# going to the correct workdirectory and start the grafana server
WORKDIR grafana-7.2.0
CMD ./bin/grafana-server

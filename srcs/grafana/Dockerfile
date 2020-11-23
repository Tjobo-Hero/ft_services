FROM alpine:latest

RUN apk update && \
	apk add vim wget curl libc6-compat

RUN wget https://dl.grafana.com/oss/release/grafana-7.2.0.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.2.0.linux-amd64.tar.gz

COPY default.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY *.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY default.yaml /usr/share/grafana/conf/provisioning/dashboards/

COPY ./grafana.db ./grafana-7.2.0/data/grafana.db

EXPOSE 3000

WORKDIR grafana-7.2.0
CMD ./bin/grafana-server


FROM alpine:latest

RUN apk update && \
	apk add influxdb

CMD influxd run

EXPOSE 8086

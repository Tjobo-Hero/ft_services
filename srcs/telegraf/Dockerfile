FROM alpine:latest

RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add telegraf --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

COPY telegraf.conf /etc/telegraf/telegraf.conf

# MAKES SURE THE CONTAINER KEEPS RUNNING
CMD telegraf

# We need to build from Alpine Linux.
FROM alpine:latest

# Download and install Telegraf.
# RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz && \
# 	tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz && \
# 	chmod +x telegraf/telegraf && \
# 	cp telegraf/telegraf /usr/bin/

RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add telegraf --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

# Copy the Telegraf configuration file.
COPY telegraf.conf /etc/telegraf/telegraf.conf

# Expose port 8125.
# EXPOSE 8086

# Keep the container running.
CMD telegraf

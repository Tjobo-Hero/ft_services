FROM alpine:latest

RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add telegraf --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

# Copy the Telegraf configuration file.
COPY telegraf.conf /etc/telegraf/telegraf.conf

# Expose port 8125.
# EXPOSE 8086

# Keep the container running.
CMD telegraf

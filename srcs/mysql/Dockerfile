FROM alpine:latest

RUN apk update && \
	apk add mysql && \
	apk add mysql-client

COPY create_database.sql /create_database.sql
COPY my.cnf /etc/my.cnf

COPY start.sh /start.sh
CMD ./start.sh

EXPOSE 3306
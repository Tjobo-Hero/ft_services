FROM alpine:latest

RUN apk upgrade
RUN apk add openssl vsftpd
RUN apk add jq curl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=NL/ST=NH/O=Codam/CN=wbarendr' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
RUN mkdir -p /var/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY start.sh /tmp/

EXPOSE 20 21 30000 30001 30002

ENTRYPOINT ["/tmp/start.sh"]

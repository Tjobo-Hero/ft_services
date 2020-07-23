  
  
FROM alpine:latest

RUN apk upgrade \
    # && echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add openssl \
    && apk add vsftpd \
    && rm -rf /var/cache/apk/*

COPY vsftpd.conf  /etc/vsftpd/vsftpd.conf
COPY setup.sh .

RUN chmod +x setup.sh

EXPOSE 21 20 21000 21001 21002

CMD ./setup.sh
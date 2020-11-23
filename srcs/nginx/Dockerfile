FROM alpine:latest

RUN apk update && \
	apk add nginx && \
	apk add openssh

RUN mkdir /var/run/nginx && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx

RUN	mkdir /interwebs && \
	chown -R www:www /interwebs

COPY index.html /interwebs/index.html
COPY nginx.conf /etc/nginx/nginx.conf
COPY private.key /etc/ssl/private.key
COPY public.crt /etc/ssl/public.crt

# CREAT SSH USER
run adduser -h / -D tvan-cit && \
	echo "tvan-cit:thisisworking" | chpasswd

COPY sshd_config /etc/ssh/sshd_config

COPY start.sh /start.sh
CMD ./start.sh

EXPOSE 22 80 443

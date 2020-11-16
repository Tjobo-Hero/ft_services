FROM alpine:latest

RUN apk update && \
	apk add php7 php7-fpm php7-mbstring php7-json php7-session php7-mysqli && \
	apk add nginx

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	mkdir -p interwebs/tmp && \
	tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /interwebs

RUN mkdir /var/run/nginx && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /interwebs

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.inc.php /interwebs/config.inc.php
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ./start.sh

EXPOSE 5000

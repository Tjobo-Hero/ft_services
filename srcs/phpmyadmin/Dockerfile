FROM alpine:latest

RUN apk update && \
	apk add php7 php7-fpm php7-mbstring php7-json php7-session php7-mysqli && \
	apk add nginx

RUN	mkdir -p /interwebs && \
	mkdir -p /interwebs/phpmyadmin && \
	mkdir -p /interwebs/tmp && \
	mkdir -p interwebs/phpmyadmin/tmp && \
	mkdir -p interwebs/tmp && \
	mkdir -p var/run/nginx 

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
	tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /interwebs && \
	tar -xzvf phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /interwebs/phpmyadmin && \
	rm phpMyAdmin-5.0.1-english.tar.gz

RUN adduser -D -g 'www' www && \
	chown -R www:www /interwebs && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /interwebs/tmp && \
	chown -R www:www /interwebs/phpmyadmin/tmp

COPY config.inc.php /interwebs/
COPY config.inc.php /interwebs/phpmyadmin/
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ./start.sh

EXPOSE 5000

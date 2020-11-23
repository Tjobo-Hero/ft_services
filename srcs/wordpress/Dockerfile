FROM alpine:latest

RUN apk update && \
	apk add nginx sudo mysql-client jq curl && \
	apk add php7 php7-fpm php7-opcache php7-common php7-curl php7-json \
			php7-mbstring php7-xml php7-zip php7-gd php7-soap php7-tokenizer \
			php7-dom php7-exif php7-fileinfo php7-mysqli php7-zlib php7-phar

RUN mkdir /var/run/nginx && \
	mkdir -p /interwebs && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /interwebs

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O usr/local/bin/wp && \
	chmod 755 /usr/local/bin/wp

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
# COPY wp-config.php interwebs/

RUN wp core download --path=interwebs

CMD ./start.sh

EXPOSE 5050

FROM 	alpine:latest

ARG		IP
RUN 	apk update
RUN 	apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib\
			php7-curl php7-mbstring php7-json php7-session
ADD		https://wordpress.org/latest.tar.gz /etc/
RUN		tar -xvf /etc/latest.tar.gz -C /etc > /dev/null && rm -f /etc/latest.tar.gz > /dev/null
COPY	./wp-config.php /etc/wordpress/
COPY 	./run.sh /tmp/run.sh
RUN 	chmod +x /tmp/run.sh
RUN		sed -i "s/AAAIPAAA/${IP}/g" /etc/wordpress/wp-config.php

EXPOSE 5050
ENTRYPOINT	[ "/tmp/run.sh"]

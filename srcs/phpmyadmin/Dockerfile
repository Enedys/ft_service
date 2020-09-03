FROM 	alpine:latest

RUN 	apk update
RUN 	apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib\
			php7-curl php7-mbstring php7-json php7-session
ADD		https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz /etc/
RUN		tar -xvf /etc/phpMyAdmin-5.0.2-all-languages.tar.gz -C /etc/. && rm -f /etc/phpMyAdmin-5.0.2-all-languages.tar.gz && \
		mv /etc/phpMyAdmin-5.0.2-all-languages /etc/phpmyadmin
COPY 	./run.sh /tmp/run.sh
RUN 	chmod +x /tmp/run.sh
COPY 	./config.inc.php /etc/phpmyadmin/config.inc.php

EXPOSE 5000
ENTRYPOINT ["/tmp/run.sh"]
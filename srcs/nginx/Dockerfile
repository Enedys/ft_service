# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/26 14:18:46 by kwillum           #+#    #+#              #
#    Updated: 2020/09/14 20:52:28 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN			apk update
RUN			apk add nginx
RUN			apk add openssh
RUN			apk add openssl
RUN			apk add openrc
RUN 		apk add supervisor
ARG			IP

VOLUME		[ "/sys/fs/cgroup" ]
RUN			mkdir -p /run/nginx
RUN			rm -f /etc/nginx/conf.d/*.conf
COPY		./nginx.conf /etc/nginx/conf.d/default.conf
COPY		./cert.crt /etc/nginx/ssl/
COPY		./key.key /etc/nginx/ssl/
RUN			sed -i "s/aaaipaaa/${IP}/g" /etc/nginx/conf.d/default.conf
RUN			echo "daemon off;" >> /etc/nginx/nginx.conf

COPY		./supervisor.conf /etc/supervisord.conf
RUN			chmod +rw /etc/supervisord.conf
RUN			echo -e "SUPER_POWERfull_PASS228\nSUPER_POWERfull_PASS228" | adduser ssh_peer 
COPY		./start.sh /tmp/start.sh
RUN			chmod u+x /tmp/start.sh

EXPOSE		443 80 22

ENTRYPOINT	["/tmp/start.sh"]

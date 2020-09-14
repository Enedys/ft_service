# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/26 14:18:46 by kwillum           #+#    #+#              #
#    Updated: 2020/09/14 14:05:47 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN			apk update
RUN			apk add nginx
RUN			apk add openssh
RUN			apk add openssl
ARG			IP

RUN			mkdir -p /run/nginx
RUN			rm -f /etc/nginx/conf.d/*.conf
COPY		./nginx.conf /etc/nginx/conf.d/default.conf
COPY		./cert.crt /etc/nginx/ssl/
COPY		./key.key /etc/nginx/ssl/
RUN			sed -i "s/aaaipaaa/${IP}/g" /etc/nginx/conf.d/default.conf
RUN			echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE		443 80 22

ENTRYPOINT	["nginx"]

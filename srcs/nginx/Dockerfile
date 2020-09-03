# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/26 14:18:46 by kwillum           #+#    #+#              #
#    Updated: 2020/08/31 14:44:12 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

RUN			apk update
RUN			apk add nginx
RUN			apk add openssh
RUN			apk add openssl

RUN			mkdir -p /run/nginx
RUN			rm -f /etc/nginx/conf.d/*.conf
COPY		./nginx.conf /etc/nginx/conf.d/default.conf
COPY		./cert.crt /etc/nginx/ssl/
COPY		./key.key /etc/nginx/ssl/
RUN			echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE		443 80 22

ENTRYPOINT	["nginx"]

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/12 16:48:54 by kwillum           #+#    #+#              #
#    Updated: 2020/09/12 21:02:33 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

RUN 	apk update
RUN		apk add influxdb

EXPOSE	8086

ENTRYPOINT ["/usr/sbin/influxd"]
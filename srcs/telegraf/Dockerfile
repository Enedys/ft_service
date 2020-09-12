# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/12 22:49:52 by kwillum           #+#    #+#              #
#    Updated: 2020/09/12 22:50:13 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine

RUN		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

ENTRYPOINT ["/usr/bin/telegraf"]

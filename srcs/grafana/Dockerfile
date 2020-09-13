# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/13 17:53:39 by kwillum           #+#    #+#              #
#    Updated: 2020/09/13 18:39:30 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

RUN 	apk add grafana --repository=http://dl-3.alpinelinux.org/alpine/edge/testing/

COPY	influxdb-datasource.yaml /usr/share/grafana/conf/provisioning/datasources/influxdb.yaml
COPY	dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY	./services/. /var/lib/grafana/dashboards/

EXPOSE	3000

ENTRYPOINT ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana"]
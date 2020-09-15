# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kwillum <kwillum@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/10 15:49:50 by kwillum           #+#    #+#              #
#    Updated: 2020/09/15 15:28:56 by kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:latest

ARG 	IP
RUN		apk update
RUN		apk add openrc openssl vsftpd
RUN 	apk add --no-cache --upgrade bash && rm -rf /var/cache/apk/*
RUN 	mkdir -p /var/ftp

COPY	./my_vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY	start.sh /tmp/
RUN		chmod +x /tmp/start.sh
RUN		mkdir -p  /ftp_anon ;
RUN		mkdir -p  /ftp_peer ;
RUN		echo "super file!" > /ftp_peer/text.txt
RUN		echo -e "SUPER_POWERfull_PASS228\nSUPER_POWERfull_PASS228" | adduser ftp_peer -s /bin/false -h /ftp_peer ;
RUN		echo "/bin/false" >> /etc/shells
RUN		chown ftp_peer:ftp_peer /ftp_peer ;
RUN		echo "Done!"
RUN 	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=RU/ST=Moscow/O=21school/CN=Kwillum' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
RUN		sed -i "s/AAAIPAAA/${IP}/g" /etc/vsftpd/vsftpd.conf

EXPOSE	20 21 22 21000-22000

ENTRYPOINT ["/tmp/start.sh"]
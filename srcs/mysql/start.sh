#!/bin/sh

/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql" > /dev/null ;
/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/init_database.txt ;
rc default ;
rc-service mariadb start ;
mysql -u root wordpress < /tmp/wordpress.sql ;
rc-service mariadb stop ;
/usr/bin/mysqld_safe --datadir="/var/lib/mysql" ;

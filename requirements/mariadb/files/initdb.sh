#!/bin/bash

# Variable that contains the path to the SQL file that will be used to initialize our db
MYSQL_INIT_FILE="/createdb.sql"

# Suppresses all the messages stdout and stderr to the /dev/null path

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

# Start the MariaDB service
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then

	rm -f "$MYSQL_INIT_FILE"
	echo "INSIDE THE CONDITION"
	echo "CREATE DATABASE $MYSQL_DATABASE;" >> "$MYSQL_INIT_FILE"
	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> "$MYSQL_INIT_FILE"
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> "$MYSQL_INIT_FILE"
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> "$MYSQL_INIT_FILE"
	echo "ALTER USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> "$MYSQL_INIT_FILE"
	echo "FLUSH PRIVILEGES;" >> "$MYSQL_INIT_FILE"
#	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql >/dev/null 2>&1
# Initialize the database and create user if not already done
#	mysql -u root -e "CREATE DATABASE IF NOT EXISTS \´${WORDPRESS_DB_NAME}\´;"
#	mysql -u root -e "CREATE USER \´${WORDPRESS_DB_USER}\´@'localhost' IDENTIFIED BY '${WORDPRESS_DB_USER}';"
#	mysql -u root -e "GRANT ALL PRIVILEGES ON \´${WORDPRESS_DB_NAME}\´.* TO \´${WORDPRESS_DB_USER}\´@'%'IDENTIFIED BY '${WORDPRESS_DB_USER}';"

#	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${WORDPRESS_USER_PASSWORD}';"

#	mysql -u root -e "FLUSH PRIVILEGES;"
	mysqld_safe --init-file=$MYSQL_INIT_FILE >/dev/null 2>&1
else
	mysqld_safe >/dev/null 2>&1
fi

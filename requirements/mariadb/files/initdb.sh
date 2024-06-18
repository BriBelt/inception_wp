#!/bin/bash

# Variable that contains the path to the SQL file that will be used to initialize our db
MYSQL_INIT_FILE="/createdb.sql"
set -e

# Suppresses all the messages stdout and stderr to the /dev/null path
mysql_install_db >/dev/null 2>&1

# Start the MariaDB service
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	rm -f "$MYSQL_INIT_FILE"
#service mysql start

#service mysql status 


# Initialize the database and create user if not already done
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS \´${WORDPRESS_DB_NAME}\´;"
	mysql -u root -e "CREATE USER \´${WORDPRESS_DB_USER}\´@'localhost' IDENTIFIED BY '${WORDPRESS_DB_USER}';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON \´${WORDPRESS_DB_NAME}\´.* TO \´${WORDPRESS_DB_USER}\´@'%'IDENTIFIED BY '${WORDPRESS_DB_USER}';"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${WORDPRESS_USER_PASSWORD}';"

	mysql -u root -e "FLUSH PRIVILEGES;"
	mysqld_safe --init-file=$MYSQL_INIT_FILE >/dev/null 2>&1
else
	mysqld_safe >/dev/null 2>&1
fi
# Execute the CMD specified in the Dockerfile

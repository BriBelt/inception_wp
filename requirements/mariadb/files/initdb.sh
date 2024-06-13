#!/bin/bash
set -e

# Start the MariaDB service
mysql_install_db >/dev/null 2>&1

service mysql start

service mysql status 

sleep 5

# Initialize the database and create user if not already done
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \´${WORDPRESS_DB_NAME}\´;"
mysql -u root -e "CREATE USER \´${WORDPRESS_DB_USER}\´@'localhost' IDENTIFIED BY '${WORDPRESS_DB_USER}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \´${WORDPRESS_DB_NAME}\´.* TO \´${WORDPRESS_DB_USER}\´@'%'IDENTIFIED BY '${WORDPRESS_DB_USER}';"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${WORDPRESS_USER_PASSWORD}';"

mysql -u root -e "FLUSH PRIVILEGES;"

echo "Database and user created."

# Execute the CMD specified in the Dockerfile
exec "$@"


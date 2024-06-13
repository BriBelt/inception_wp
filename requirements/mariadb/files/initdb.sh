#!/bin/bash
set -e

# Start the MariaDB service
mysql_install_db >/dev/null 2>&1

service mysql start

service mysql status 

sleep 5

# Initialize the database and create user if not already done
mysql -u root -e "CREATE DATABASE IF NOT EXISTS WordPress;"
mysql -u root -e "CREATE USER 'user'@'%' IDENTIFIED BY 'password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON WordPress.* TO 'user'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
echo "Database and user created."

# Execute the CMD specified in the Dockerfile
exec "$@"


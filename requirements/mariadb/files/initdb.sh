#!/bin/bash
set -e

# Start the MariaDB service
service mysql start

# Wait for the database service to start up
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Initialize the database and create user if not already done
if [ -z "$(mysql -u root -e 'SHOW DATABASES LIKE "WordPress";')" ]; then
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS WordPress;"
    mysql -u root -e "CREATE USER 'user'@'%' IDENTIFIED BY 'password';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON WordPress.* TO 'user'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    echo "Database and user created."
else
    echo "Database already exists."
fi

# Stop the MariaDB service
service mysql stop

# Execute the CMD specified in the Dockerfile
exec "$@"


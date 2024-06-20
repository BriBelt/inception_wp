#!/bin/bash

# Variable that contains the path to the SQL file that will be used to initialize our db
MYSQL_INIT_FILE="/createdb.sql"

# Suppresses all the messages stdout and stderr to the /dev/null path

chown -R mysql: /var/lib/mysql
chmod 777 /var/lib/mysql

mysql_install_db >/dev/null 2>&1

# Start the MariaDB service
echo "Creating and configuring database, users, etc..."
echo "MYSQL_DATABASE = '$MYSQL_USER'"
echo "CREATE DATABASE $MYSQL_DATABASE;" >> "$MYSQL_INIT_FILE"
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> "$MYSQL_INIT_FILE"
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> "$MYSQL_INIT_FILE"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> "$MYSQL_INIT_FILE"
echo "ALTER USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> "$MYSQL_INIT_FILE"
echo "FLUSH PRIVILEGES;" >> "$MYSQL_INIT_FILE"

echo "Booting up the database..."

mysqld_safe --init-file=$MYSQL_INIT_FILE >/dev/null 2>&1

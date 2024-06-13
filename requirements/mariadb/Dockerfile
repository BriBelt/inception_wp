FROM debian:bullseye

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Exposing the default MariaDB port
EXPOSE 3306

# Initialize the database
RUN service mysql start && mysql -u root -e "CREATE DATABASE IF \
    NOT EXISTS WordPress;" && mysql -u root -e "CREATE USER 'user'@'localhost' \    IDENTIFIED BY 'password' && GRANT ALL PRIVILEGES ON WordPress.* TO \
    'user'@'localhost' && \
    EXIT;

CMD ["mysqld"]


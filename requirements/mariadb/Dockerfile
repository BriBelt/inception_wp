FROM debian:bullseye

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /run/mysql

# Exposing the default MariaDB port
EXPOSE 3306

COPY files/initdb.sh /initdb.sh

RUN chmod +x /initdb.sh

ENTRYPOINT ["/initdb.sh"]
# Initialize the database
CMD mysqld_safe

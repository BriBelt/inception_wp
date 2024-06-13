FROM debian:bullseye

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Exposing the default MariaDB port
EXPOSE 3306

COPY files/initdb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/initdb.sh

# Initialize the database
ENTRYPOINT ["/usr/local/bin/initdb.sh"]

CMD ["mysqld"]


FROM debian:bullseye

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /run/mysql

COPY files/50-server.cnf /etc/mysql/mariadb/mariabd.conf.d/.

COPY files/initdb.sh /initdb.sh

RUN chmod +x /initdb.sh

#RUN touch /run/mysqld/mysql.sock

# Initialize the database
CMD ["/initdb.sh"] 

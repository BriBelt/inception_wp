FROM debian:bullseye

# Install php, and needed tools to install wordpress
RUN apt-get update && apt-get install -y php7.4 \
	php7.4-mysql php7.4-fpm curl \
	wget mariadb-client && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Get WordPress
WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mkdir -p /run/php/ && \
    rm -rf latest.tar.gz wordpress

# Set the correct permissions for wordpress
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 755 /run/php

EXPOSE 443 

COPY files/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf 

COPY files/config.sh /usr/local/bin/config.sh

RUN chmod +x /usr/local/bin/config.sh

ENTRYPOINT ["/usr/local/bin/config.sh"]

CMD ["php-fpm7.4", "-F"]

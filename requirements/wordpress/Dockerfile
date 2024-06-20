FROM debian:bullseye

# Install php, and needed tools to install wordpress
RUN apt-get update && apt-get install -y php7.4 \
	php7.4-mysql php7.4-fpm curl zip unzip \
	wget sendmail mariadb-client && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Get WordPress

RUN mkdir -p /var/www/html && cd /var/www/html

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mkdir -p /run/php/ && \
    rm -rf latest.zip && \
    mv wordpress/* . && rmdir wordpress && \

# Set the correct permissions for wordpress
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 755 /run/php

EXPOSE 443 

COPY files/www.conf /etc/php/7.4/fpm/www.conf 

COPY files/config.sh /var/www/config.sh

RUN chmod +x /var/www/config.sh

WORKDIR /var/www/html

CMD ["/var/www/config.sh"]

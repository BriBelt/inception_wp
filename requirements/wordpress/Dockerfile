FROM debian:bullseye

# Install php, and needed tools to install wordpress
RUN apt-get update && apt-get install -y php7.4 \
	php7.4-mysql php7.4-fpm curl \
	wget mariadb-client && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent

RUN chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/

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

RUN wp core download --allow-root

RUN wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

RUN wp core install --url=$DOMAIN_NAME --title="WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root

RUN wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

EXPOSE 443 

COPY files/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf 

CMD ["php-fpm7.4", "-F"]

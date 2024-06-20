FROM debian:bullseye

# Install php, and needed tools to install wordpress.
RUN apt-get update && apt-get install -y php7.4 \
	php7.4-mysql php7.4-fpm curl zip unzip \
	wget sendmail mariadb-client && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install WP-CLI command-tool for WordPress.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Create the needed directory for Wordpress files
# if is not created.
# Set the owner to the directory.
# Set permissions to the directory, so the owner
# can execute, etc, while the others can only read
# and execute.
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Get WordPress
#RUN wget https://wordpress.org/latest.zip && \
#    unzip latest.zip && \
RUN mkdir -p /run/php/ && \
    chmod -R 755 /run/php
    #rm -rf latest.zip && \
    #mv wordpress/* /var/www/html/ && rmdir wordpress && \

EXPOSE 443 

# Copy the PHP configuration file inside the PHP
# directory.
COPY files/www.conf /etc/php/7.4/fpm/www.conf 

# Copy the script tha will get WordPress and 
# configure it.
COPY files/config.sh /var/www/config.sh

COPY files/wp-config.php.custom /var/www/wp-config.php.custom

# Set permissions to the script so we can execute it.
RUN chmod +x /var/www/config.sh

WORKDIR /var/www/html

CMD ["/var/www/config.sh"]

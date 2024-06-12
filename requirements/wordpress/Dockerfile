FROM debian:bullseye

RUN apt update && apt install -y php \
	php-mysql php-fpm php-curl php-gd php-intl \
	php-mbstring php-soap php-xml \
	php-xmlrpc php-zip wget unzip && apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mkdir -p /var/www/html/ && \
    mkdir -p /run/php/ && \
    mv wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 755 /run/php

EXPOSE 9000

COPY files/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf 

CMD ["php-fpm7.4", "-F"]

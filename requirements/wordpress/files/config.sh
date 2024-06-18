#!/bin/sh

# check if the file exists
# if it does do not create, run it
# if not, create it
# also do it in the mariadb .sh
# /var/www/html/
if [ -f /var/www/html/wp-config.ph ]; then
	echo "Wordpress is already installed"
else

	wp core download --allow-root

	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

	wp core install --url=$DOMAIN_NAME --title="WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root

	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
fi

/usr/sbin/php-fpm7.4 --nodaemonize

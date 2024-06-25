#!/bin/sh

sleep 10 

if [ -f ./wp-config.php ]; then
	echo "Wordpress is already installed"
else
	echo "Downloading WordPress..."
	wp core download --allow-root

	echo "Creating Wordpress/Mariadb connection..."
	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

	echo "Installing WordPress..."
	wp core install --url=$DOMAIN_NAME --title="WordPress Site" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root

	echo "Creating a user..."
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
	echo "Setting role for $WORDPRESS_USER..."
	wp user set-role $WORDPRESS_USER editor
	echo "Wordpress was correctly installed!"
fi


/usr/sbin/php-fpm7.4 --nodaemonize

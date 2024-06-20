FROM debian:bullseye

# Install nginx and openssl to create the certificates
RUN apt-get update && apt-get install -y nginx openssl && \
	apt-get install -y gettext-base && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create the certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	#-subj "/CN=${DOMAIN_NAME}/C=EU/ST=Madrid" \
	-subj "/CN=bbeltran.42.fr/C=EU/ST=Madrid" \
	-keyout /etc/ssl/private/rootKey.key \
	-out /etc/ssl/certs/rootCert.crt

# Copy the configuration for nginx
COPY files/default /etc/nginx/conf.d/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

# Dockerfile, set of instructions that on how to build a
# Docker image. Docker images work in layers, therefore
# each Dockerfile instruction is a layer added to the
# image.
FROM debian:bullseye

# Install nginx and openssl to create the certificates
RUN apt-get update && apt-get install -y nginx openssl && \
	apt-get install -y gettext-base && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create the SSL/TLS certificate.
# An SSL/TLS certificate is a digital certificate that authenticates
# the identity of a website and encrypts the data sent between the
# website and its users. Secures data transmission over the internet.
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/CN=bbeltran.42.fr/C=EU/ST=Madrid" \
	-keyout /etc/ssl/private/rootKey.key \
	-out /etc/ssl/certs/rootCert.crt

# Copy the configuration for nginx
COPY files/default /etc/nginx/conf.d/nginx.conf

EXPOSE 443

# Run the NGINX web server in the foreground instead of the background
# (daemon mode).
CMD ["nginx", "-g", "daemon off;"]

# Abode Software - DevOps Lifecycle
FROM hshar/webapp

WORKDIR /var/www/html
COPY . /var/www/html
EXPOSE 80

# Keep the base image's default web-server command.

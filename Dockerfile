FROM php:8.3-apache-bookworm

WORKDIR /var/www/html

RUN a2enmod rewrite \
    && sed -ri '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
    && mkdir -p /var/data /tmp/expire-dialog-storage

COPY index.php /var/www/html/index.php
COPY .htaccess /var/www/html/.htaccess
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint

RUN chmod 0755 /usr/local/bin/docker-entrypoint

ENV PORT=10000
EXPOSE 10000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

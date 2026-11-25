#!/bin/sh
set -eu

port="${PORT:-10000}"
case "$port" in
    ''|*[!0-9]*)
        echo "PORT must contain only digits" >&2
        exit 1
        ;;
esac

sed -ri "s/^Listen [0-9]+$/Listen ${port}/" /etc/apache2/ports.conf
sed -ri "s/<VirtualHost \\*:[0-9]+>/<VirtualHost *:${port}>/" /etc/apache2/sites-available/000-default.conf

storage_dir="${KEY_STORAGE_DIR:-${RAILWAY_VOLUME_MOUNT_PATH:-/tmp/expire-dialog-storage}}"
mkdir -p "$storage_dir"
chown -R www-data:www-data "$storage_dir"
export KEY_STORAGE_DIR="$storage_dir"

exec apache2-foreground

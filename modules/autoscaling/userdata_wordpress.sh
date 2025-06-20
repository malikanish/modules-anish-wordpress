#!/bin/bash

set -e
set -x

WP_DB_NAME="wordpress"
WP_DB_USER="wpuser"
WP_DB_PASS="password"
WP_DB_HOST="${db_ip}" 
WP_DIR="/var/www/html"

# Install packages
apt update && apt upgrade -y
apt install -y apache2 php libapache2-mod-php php-mysql php-curl php-xml php-mbstring php-zip wget unzip

# Start Apache
systemctl enable apache2
systemctl start apache2


rm -rf $${WP_DIR:?}/*

# Download and extract WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* "$${WP_DIR}"


cd "$${WP_DIR}"
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$${WP_DB_NAME}/" wp-config.php
sed -i "s/username_here/$${WP_DB_USER}/" wp-config.php
sed -i "s/password_here/$${WP_DB_PASS}/" wp-config.php
sed -i "s/localhost/$${WP_DB_HOST}/" wp-config.php

# Permissions
chown -R www-data:www-data "$${WP_DIR}"
chmod -R 755 "$${WP_DIR}"

systemctl restart apache2

echo "✅ WordPress installed at http://your_public_ip"

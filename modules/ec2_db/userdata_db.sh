#!/bin/bash

set -e
set -x

MYSQL_ROOT_PASSWORD="rootpassword"
WP_DB_NAME="wordpress"
WP_DB_USER="wpuser"
WP_DB_PASS="password"

# Install MySQL
apt update && apt install -y mysql-server

# Enable & Start MySQL
systemctl enable mysql
systemctl start mysql

# Secure root user
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Create DB & WordPress user
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;
CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASS';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Allow remote connections
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

echo "✅ MySQL setup complete and open for WordPress connection"

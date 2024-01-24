#!/bin/bash

# Verificar si se proporciona un nombre de usuario
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Definir variables
USERNAME="$1"
DOMAIN="failchat.duckdns.org"

# Crear nuevo usuario
sudo adduser $USERNAME

# Instalar PostgreSQL y php-pgsql
sudo apt-get update
sudo apt-get install -y apache2 postgresql php php-pgsql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Configurar base de datos PostgreSQL
sudo -u postgres createuser -s ${USERNAME}_user
sudo -u postgres createdb ${USERNAME}_db
sudo -u postgres psql -c "ALTER USER ${USERNAME}_user WITH PASSWORD 'P@ssword';"

# Descargar e instalar WordPress
sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo rm -rf wordpress latest.tar.gz

# Configurar archivo wp-config.php para PostgreSQL
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/${USERNAME}_db/" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${USERNAME}_user/" /var/www/html/wp-config.php
sudo sed -i "s/password_here/password/" /var/www/html/wp-config.php
sudo sed -i "s/localhost/localhost/" /var/www/html/wp-config.php

# Mensaje de finalización
echo "WordPress con PostgreSQL instalado para el usuario ${USERNAME}."

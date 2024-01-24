#!/bin/bash

# Verificar si se proporciona un nombre de usuario
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Definir variables
USERNAME="$1"
DOMAIN="failchat-help.duckdns.org"

# Crear nuevo usuario
sudo adduser $USERNAME

# Instalar WordPress
sudo apt-get update
sudo apt-get install -y apache2 mariadb-server php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Configurar base de datos
sudo mysql_secure_installation
sudo mysql -e "CREATE DATABASE ${USERNAME}_db;"
sudo mysql -e "CREATE USER '${USERNAME}_user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${USERNAME}_db.* TO '${USERNAME}_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Descargar e instalar WordPress
sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo rm -rf wordpress latest.tar.gz

# Mensaje de finalización
echo "WordPress instalado para el usuario ${USERNAME}."

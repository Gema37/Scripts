#!/bin/bash
mkdir wordpress
cd wordpress
echo 'version: "3"
# Defines which compose version to use
services:
  # Services line define which Docker images to run. In this case, it will be MySQL server and WordPress image.
  db:
    image: mysql:latest
    # image: mysql:5.7 indicates the MySQL database container image from Docker Hub used in this installation.
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456789
      MYSQL_DATABASE: wordpressdb
      MYSQL_USER: equipo1
      MYSQL_PASSWORD: 1234
      # Previous four lines define the main variables needed for the MySQL container to work: database, database username, database user password, and the MySQL root password.
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    restart: always
    # Restart line controls the restart mode, meaning if the container stops running for any reason, it will restart the process immediately.
    ports:
      - "8085:80"
      # The previous line defines the port that the WordPress container will use. After successful installation, the full path will look like this: http://localhost:8085
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: equipo1
      WORDPRESS_DB_PASSWORD: 1234
      WORDPRESS_DB_NAME: wordpressdb
# Similar to MySQL image variables, the last four lines define the main variables needed for the WordPress container to work properly with the MySQL container.
    volumes:
      ["./:/var/www/html"]
volumes:
  mysql: {}' > docker-compose.yml
sudo docker compose up -d
exit
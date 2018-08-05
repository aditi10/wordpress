#!/bin/bash

sudo apt-get update -y
yes mysql123|sudo apt-get install lamp-server
sudo apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd -y

dbname=demo
dbuser=mysql123
dbpass=mysql123
mysql_host=mysql-private.myvpc
#
#DOWNLOAD & INSTALL WORDPRESS
cd ~
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

sudo mkdir -p /var/www/html
sudo mv wordpress /var/www/html

sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
cd /var/www/html/wordpress
#sudo mv wp-config-sample.php wp-config.php
sudo cp wp-config-sample.php wp-config.php

#set database details with perl find and replace
sudo perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
sudo perl -pi -e "s/username_here/$dbuser/g" wp-config.php
sudo perl -pi -e "s/password_here/$dbpass/g" wp-config.php
sudo perl -pi -e "s/localhost/$mysql_host/g" wp-config.php

#set WP salts
sudo perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

sudo systemctl restart apache2.service


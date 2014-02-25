#!/bin/bash

mysql -uroot -proot < "/vagrant/scripts/enable_remote_mysql_access.sql"
sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
sudo service mysql restart

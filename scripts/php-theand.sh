#!/bin/bash

sed -i "s/^disable_functions/;disable_functions/" /etc/php5/fpm/php.ini
sed -i "s/^disable_functions/;disable_functions/" /etc/php5/cli/php.ini
#sed -i "s/^error_reporting = E_ALL$/error_reporting = E_ALL \& ~E_NOTICE/" /etc/php5/fpm/php.ini
sudo service php5-fpm restart

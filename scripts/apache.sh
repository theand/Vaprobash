#!/usr/bin/env bash

# Test if PHP is installed
php -v > /dev/null 2>&1
PHP_IS_INSTALLED=$?

echo ">>> Installing Apache Server"

[[ -z "$1" ]] && { echo "!!! IP address not set. Check the Vagrant file."; exit 1; }

if [ -z "$2" ]; then
	public_folder="/vagrant"
else
	public_folder="$2"
fi

# Add repo for latest FULL stable Apache
# (Required to remove conflicts with PHP PPA due to partial Apache upgrade within it)
sudo add-apt-repository -y ppa:ondrej/apache2

# Update Again
sudo launchpad-getkeys
sudo apt-key update
sudo apt-get update

# Install Apache
sudo apt-get install -qq  apache2-mpm-event libapache2-mod-fastcgi

echo ">>> Configuring Apache"

# Add vagrant user to www-data group
sudo usermod -a -G www-data vagrant

# Apache Config
# On separate lines since some may cause an error
# if not installed
sudo a2dismod mpm_prefork
sudo a2dismod php5
sudo a2enmod mpm_worker rewrite actions ssl
curl -L https://gist.githubusercontent.com/fideloper/2710970/raw/vhost.sh > vhost
sudo chmod guo+x vhost
sudo mv vhost /usr/local/bin

# Create a virtualhost to start, with SSL certificate
sudo vhost -s $1.xip.io -d $public_folder -p /etc/ssl/xip.io -c xip.io
sudo a2dissite 000-default

if [[ $PHP_IS_INSTALLED -eq 0 ]]; then
    # PHP Config for Apache
    cat > /etc/apache2/conf-available/php5-fpm.conf << EOF
    <IfModule mod_fastcgi.c>
            AddHandler php5-fcgi .php
            Action php5-fcgi /php5-fcgi
            Alias /php5-fcgi /usr/lib/cgi-bin/php5-fcgi
            FastCgiExternalServer /usr/lib/cgi-bin/php5-fcgi -socket /var/run/php5-fpm.sock -pass-header Authorization
            <Directory /usr/lib/cgi-bin>
                    Options ExecCGI FollowSymLinks
                    SetHandler fastcgi-script
                    Require all granted
            </Directory>
    </IfModule>
EOF
    sudo a2enconf php5-fpm
		sudo a2enmod proxy_fcgi
		# Add ProxyPassMatch to pass to php in document root
    sudo sed -i "s@#ProxyPassMatch.*@ProxyPassMatch ^/(.*\\\.php(/.*)?)$ fcgi://127.0.0.1:9000"$public_folder"/\$1@" /etc/apache2/sites-available/$1.xip.io.conf
		sudo chmod 777 /var/lib/apache2/fastcgi -R

fi

sudo service apache2 restart

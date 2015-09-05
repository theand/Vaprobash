#!/bin/bash

cd /etc/apache2/sites-available/
sudo ln -s /vagrant/vhost/book-new.dev.conf
sudo ln -s /vagrant/vhost/clean-center.dev.conf
sudo ln -s /vagrant/vhost/hr.dev.conf
sudo ln -s /vagrant/vhost/hr-dkb.dev.conf
sudo ln -s /vagrant/vhost/hr-dks.dev.conf
sudo ln -s /vagrant/vhost/hr-dkt.dev.conf
sudo ln -s /vagrant/vhost/ui.dev.conf
sudo ln -s /vagrant/vhost/synonym.conf

sudo a2ensite book-new.dev.conf
sudo a2ensite clean-center.dev.conf
sudo a2ensite hr.dev.conf
sudo a2ensite hr-dkb.dev.conf
sudo a2ensite hr-dks.dev.conf
sudo a2ensite hr-dkt.dev.conf
sudo a2ensite ui.dev.conf
sudo a2ensite synonym.conf

sudo service apache2 restart

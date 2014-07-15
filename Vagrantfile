# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "fideloper"
github_repo     = "Vaprobash"
github_branch   = "1.0.0"
github_url      = "https://raw.githubusercontent.com/#{github_username}/#{github_repo}/#{github_branch}"

# Server Configuration

hostname        = "vaprobash14.dev"

# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_ip             = "192.168.22.12"
server_memory         = "512" # MB
server_swap           = "768" # Options: false | int (MB) - Guideline: Between one or two times the server_memory
server_timezone       = "Asia/Seoul"

# Database Configuration
mysql_root_password   = "root"   # We'll assume user "root"
mysql_version         = "5.5"    # Options: 5.5 | 5.6
mysql_enable_remote   = "true"  # remote access enabled when true
pgsql_root_password   = "root"   # We'll assume user "root"

# Languages and Packages
ruby_version          = "latest" # Choose what ruby version should be installed (will also be the default version)
ruby_gems             = [        # List any Ruby Gems that you want to install
  "jekyll",
  "sass",
  "compass",
]

# To install HHVM instead of PHP, set this to "true"
hhvm                  = "true"

# PHP Options
composer_packages     = [        # List any global Composer packages that you want to install
  #"phpunit/phpunit:4.0.*",
  #"codeception/codeception=*",
  #"phpspec/phpspec:2.0.*@dev",
  #"squizlabs/php_codesniffer:1.5.*",
]

# Default web server document root
# Symfony's public directory is assumed "web"
# Laravel's public directory is assumed "public"
public_folder         = "/var/www"

laravel_root_folder   = "/vagrant/laravel" # Where to install Laravel. Will `composer install` if a composer.json file exists
laravel_version       = "latest-stable" # If you need a specific version of Laravel, set it here
symfony_root_folder   = "/vagrant/symfony" # Where to install Symfony.

nodejs_version        = "latest"   # By default "latest" will equal the latest stable version
nodejs_packages       = [          # List any global NodeJS packages that you want to install
  "grunt-cli",
  "gulp",
  "bower",
  "yo"
]

Vagrant.configure("2") do |config|

  # Set server to Ubuntu 14.04
  config.vm.box = "ubuntu/trusty64"

  config.vm.define :vaprobash14


  # Create a hostname, don't forget to put it to the `hosts` file
  # This will point to the server's default virtual host
  # TO DO: Make this work with virtualhost along-side xip.io URL
  config.vm.hostname = hostname

  # Create a static IP
  config.vm.network :private_network, ip: server_ip

  #SSH 포트를 바꾸고 싶을 때는 아래 내용을 주석처리하고 host: 에 원하는 포트 번호 기입.
  config.vm.network :forwarded_port, guest: 22, host: 2200, id: 'ssh', auto_correct: true
  config.vm.network :forwarded_port, guest: 80, host: 8800, auto_correct: true #apache2
  config.vm.network :forwarded_port, guest: 3306, host: 8801, auto_correct: true #mysqld
  config.vm.network :forwarded_port, guest: 1025 , host: 8825, auto_correct: true #mailcatcher smtp
  config.vm.network :forwarded_port, guest: 1080 , host: 8826, auto_correct: true #mailcatcher http
  config.vm.network :forwarded_port, guest: 4000 , host: 8804, auto_correct: true #jekyll

  # Use NFS for the shared folder
  config.vm.synced_folder ".", "/vagrant",
#id: "core",
#:nfs => true,
#:mount_options => ['nolock,vers=3,udp,noatime']
:mount_options => [ "dmode=777", "fmode=777"]

  config.vm.synced_folder "../www", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
  config.vm.provision :shell, :inline => "echo \"Asia/Seoul\"| sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  # If using VirtualBox
  config.vm.provider :virtualbox do |vb|

    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

    # Set server memory
    vb.customize ["modifyvm", :id, "--memory", server_memory]

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    # If the clock gets more than 15 minutes out of sync (due to your laptop going
    # to sleep for instance, then some 3rd party services will reject requests.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Prevent VMs running on Ubuntu to lose internet connection
    # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

  end

  # If using VMWare Fusion
  config.vm.provider "vmware_fusion" do |vb, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

    # Set server memory
    vb.vmx["memsize"] = server_memory

  end

  # If using Vagrant-Cachier
  # http://fgrehm.viewdocs.io/vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # Usage docs: http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box

    config.cache.synced_folder_opts = {
        type: :nfs,
        mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  ####
  # Base Items
  ##########

  # Provision Base Packages
  config.vm.provision "shell", path: "scripts/base.sh", args: [github_url, server_swap]
  config.vm.provision "shell", path: "scripts/base-theand.sh"

  # Provision PHP
  config.vm.provision "shell", path: "scripts/php.sh", args: [server_timezone, hhvm]
  #config.vm.provision "shell", path: "scripts/php-theand.sh"

  # Enable MSSQL for PHP
  # config.vm.provision "shell", path: "scripts/mssql.sh"

  # Provision Vim
   config.vm.provision "shell", path: "scripts/vim.sh", args: github_url
   config.vm.provision "shell", path: "scripts/vim-theand.sh"


  ####
  # Web Servers
  ##########

  # Provision Apache Base
   config.vm.provision "shell", path: "scripts/apache.sh", args: [server_ip, public_folder, hostname, github_url]

  # Provision Nginx Base
  # config.vm.provision "shell", path: "scripts/nginx.sh", args: [server_ip, public_folder, hostname, github_url]


  ####
  # Databases
  ##########

  # Provision MySQL
  config.vm.provision "shell", path: "scripts/mysql.sh", args: [mysql_root_password, mysql_version, mysql_enable_remote]
  #config.vm.provision :shell, :path => "scripts/enable_remote_mysql_access.sh"

  # Provision PostgreSQL
  # config.vm.provision "shell", path: "scripts/pgsql.sh", args: pgsql_root_password

  # Provision SQLite
  # config.vm.provision "shell", path: "scripts/sqlite.sh"

  # Provision RethinkDB
  # config.vm.provision "shell", path: "scripts/rethinkdb.sh", args: pgsql_root_password

  # Provision Couchbase
  # config.vm.provision "shell", path: "scripts/couchbase.sh"

  # Provision CouchDB
  # config.vm.provision "shell", path: "scripts/couchdb.sh"

  # Provision MongoDB
  # config.vm.provision "shell", path: "scripts/mongodb.sh"

  # Provision MariaDB
  # config.vm.provision "shell", path: "scripts/mariadb.sh", args: [mysql_root_password, mysql_enable_remote]

  ####
  # Search Servers
  ##########

  # Install Elasticsearch
  # config.vm.provision "shell", path: "scripts/elasticsearch.sh"

  # Install SphinxSearch
  # config.vm.provision "shell", path: "scripts/sphinxsearch.sh"

  ####
  # Search Server Administration (web-based)
  ##########

  # Install ElasticHQ
  # Admin for: Elasticsearch
  # Works on: Apache2, Nginx
  # config.vm.provision "shell", path: "scripts/elastichq.sh"


  ####
  # In-Memory Stores
  ##########

  # Install Memcached
  # config.vm.provision "shell", path: "scripts/memcached.sh"

  # Provision Redis (without journaling and persistence)
  # config.vm.provision "shell", path: "scripts/redis.sh"

  # Provision Redis (with journaling and persistence)
  # config.vm.provision "shell", path: "scripts/redis.sh", args: "persistent"
  # NOTE: It is safe to run this to add persistence even if originally provisioned without persistence


  ####
  # Utility (queue)
  ##########

  # Install Beanstalkd
  # config.vm.provision "shell", path: "scripts/beanstalkd.sh"

  # Install Heroku Toolbelt
  # config.vm.provision "shell", path: "https://toolbelt.heroku.com/install-ubuntu.sh"

  # Install Supervisord
  # config.vm.provision "shell", path: "scripts/supervisord.sh"

  ####
  # Additional Languages
  ##########

  # Install Nodejs
   config.vm.provision "shell", path: "scripts/nodejs.sh", privileged: false, args: nodejs_packages.unshift(nodejs_version, github_url)

  # Install Ruby Version Manager (RVM)
   config.vm.provision "shell", path: "scripts/rvm.sh", privileged: false, args: ruby_gems.unshift(ruby_version)

  ####
  # Frameworks and Tooling
  ##########

  # Provision Composer
   config.vm.provision "shell", path: "scripts/composer.sh", privileged: false, args: composer_packages.join(" ")

  # Provision Laravel
  # config.vm.provision "shell", path: "scripts/laravel.sh", args: [server_ip, laravel_root_folder, public_folder, laravel_version]
   config.vm.provision "shell", path: "scripts/laravel-theand.sh"

  # Provision Symfony
  # config.vm.provision "shell", path: "scripts/symfony.sh", privileged: false, args: [server_ip, symfony_root_folder, public_folder]

  # Install Screen
   config.vm.provision "shell", path: "scripts/screen.sh"

  # Install Mailcatcher
   config.vm.provision "shell", path: "scripts/mailcatcher.sh"

  # Install git-ftp
  # config.vm.provision "shell", path: "scripts/git-ftp.sh", privileged: false

  ####
  # Local Scripts
  # Any local scripts you may want to run post-provisioning.
  # Add these to the same directory as the Vagrantfile.
  ##########
  # config.vm.provision "shell", path: "./local-script.sh"

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "fideloper"
github_repo     = "Vaprobash"
github_branch   = "master"

# Some variables
server_ip             = "192.168.33.10"
mysql_root_password   = "root"   # We'll assume user "root"
mysql_version         = "5.5"    # Options: 5.5 | 5.6
pgsql_root_password   = "root"   # We'll assume user "root"
mariadb_version       = "10.0"   # Options: 5.5 | 10.0
mariadb_root_password = "root"   # We'll assume user "root"
ruby_version          = "latest" # Choose what ruby version should be installed (will also be the default version)
ruby_gems             = [        # List any Ruby Gems that you want to install
  #"jekyll",
  "sass",
  "compass",
]
php_version           = "previous" # Options: latest|previous|distributed   For 12.04. latest=5.5, previous=5.4, distributed=5.3
composer_packages     = [        # List any global Composer packages that you want to install
  #"phpunit/phpunit:3.7.*",
  #"codeception/codeception=*",
]
nodejs_version        = "latest" # By default "latest" will equal the latest stable version
nodejs_packages       = [        # List any global NodeJS packages that you want to install
  #"grunt-cli",
  #"bower",
  #"yo",
  #"gulp"
]

Vagrant.configure("2") do |config|

  # Set server to Ubuntu 12.04
  config.vm.box = "precise64"

  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.define :vaprobash


  # Create a hostname, don't forget to put it to the `hosts` file
  config.vm.hostname = "vaprobash.dev"

  # Create a static IP
  config.vm.network :private_network, ip: server_ip

  config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
  config.vm.network :forwarded_port, guest: 8080, host: 8000, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true

  # Use NFS for the shared folder
  config.vm.synced_folder ".", "/vagrant",
#id: "core",
#:nfs => true,
#:mount_options => ['nolock,vers=3,udp,noatime']
            :mount_options => [ "dmode=777", "fmode=666"]

  config.vm.synced_folder "../laravel-vagrant/www", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
  config.vm.provision :shell, :inline => "echo \"Asia/Seoul\"| sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  # Optionally customize amount of RAM
  # allocated to the VM. Default is 384MB
  config.vm.provider :virtualbox do |vb|

    vb.customize ["modifyvm", :id, "--memory", "512"]

  end

  ####
  # Base Items
  ##########

  # Provision Base Packages
  config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/base.sh"

  # Provision Base Packages for theand
  config.vm.provision "shell", path: "scripts/base-theand.sh"

  # Provision PHP
  config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/php.sh", args: php_version

  # Provision Oh-My-Zsh
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/zsh.sh"

  # Provision Vim
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/vim.sh"


  ####
  # Web Servers
  ##########

  # Provision Apache Base
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/apache.sh", args: server_ip

  # Provision HHVM
  #config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/hhvm.sh"

  # Provision Nginx Base
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/nginx.sh", args: server_ip


  ####
  # Databases
  ##########

  # Provision MySQL
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mysql.sh", args: [mysql_root_password, mysql_version]

  # Provision PostgreSQL
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/pgsql.sh", args: pgsql_root_password

  # Provision SQLite
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/sqlite.sh"

  # Provision CouchDB
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/couchdb.sh"

  # Provision MongoDB
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mongodb.sh"

  # Provision MariaDB
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mariadb.sh", args: [mariadb_root_password, mariadb_version]

  ####
  # Search Servers
  ##########

  # Install Elasticsearch
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/elasticsearch.sh"


  ####
  # Search Server Administration (web-based)
  ##########

  # Install ElasticHQ
  # Admin for: Elasticsearch
  # Works on: Apache2, Nginx
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/elastichq.sh"


  ####
  # In-Memory Stores
  ##########

  # Install Memcached
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/memcached.sh"

  # Provision Redis (without journaling and persistence)
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/redis.sh"

  # Provision Redis (with journaling and persistence)
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/redis.sh", args: "persistent"
  # NOTE: It is safe to run this to add persistence even if originally provisioned without persistence


  ####
  # Utiliy (queue)
  ##########

  # Install Beanstalkd
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/beanstalkd.sh"


  ####
  # Additional Languages
  ##########

  # Install Nodejs
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/nodejs.sh", privileged: false, args: nodejs_packages.unshift(nodejs_version)

  # Install Ruby Version Manager (RVM)
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/rvm.sh", privileged: false, args: ruby_gems.unshift(ruby_version)

  ####
  # Frameworks and Tooling
  ##########

  # Provision Composer
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/composer.sh", privileged: false, args: composer_packages

  # Provision Laravel
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/laravel.sh", args: server_ip

  # Install Screen
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/screen.sh"

  # Install Supervisord
   config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/supervisord.sh"

  # Install Mailcatcher
  # config.vm.provision "shell", path: "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/scripts/mailcatcher.sh"

end

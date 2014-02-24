#!/usr/bin/env bash

echo ">>> Installing Laravel Installer"

curl -L http://laravel.com/laravel.phar 
chmod +x laravel.phar 
mv laravel.phar /usr/local/bin/laravel


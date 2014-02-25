#!/usr/bin/env bash

echo ">>> Installing Laravel Installer"

curl -LO http://laravel.com/laravel.phar
chmod +x laravel.phar
mv laravel.phar /usr/local/bin/laravel


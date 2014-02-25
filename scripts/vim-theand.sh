#!/bin/bash

sed -i "s/^Bundle 'altercation\/vim-colors-solarized'/\"Bundle 'altercation\/vim-colors-solarized'/" /home/vagrant/.vimrc
sed -i "s/^colorscheme solarized/\"colorscheme solarized/" /home/vagrant/.vimrc

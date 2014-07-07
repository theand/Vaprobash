#!/usr/bin/env bash

echo ">>> Installing Base Packages for theand"

# Update
sudo apt-get update

# Install base packages
sudo apt-get install -qq dos2unix debconf-utils w3m reportbug sendmail-bin language-pack-ko-base tree

#sudo apt-get upgrade -y

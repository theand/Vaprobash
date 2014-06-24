#!/usr/bin/env bash

echo ">>> Installing Base Packages for theand"

# Update
sudo apt-get update

# Install base packages
sudo apt-get install -y dos2unix debconf-utils w3m reportbug sendmail-bin unzip language-pack-ko-base tree ack-grep

#sudo apt-get upgrade -y


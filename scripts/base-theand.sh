#!/usr/bin/env bash

echo ">>> Installing Base Packages for theand"

sudo add-apt-repository ppa:nilarimogard/webupd8

# Update
sudo launchpad-getkeys
sudo apt-key update
sudo apt-get update

# Install base packages
sudo apt-get install -qq dos2unix debconf-utils w3m reportbug sendmail-bin language-pack-ko-base tree ack-grep launchpad-getkeys libmysqlclient-dev

#sudo apt-get upgrade -y
sudo launchpad-getkeys

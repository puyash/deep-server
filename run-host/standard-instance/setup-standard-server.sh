#!/bin/bash


apt-get update

apt-get install git

# install Docker ---------------------------
# ------------------------------------------

echo "Installing docker ..."

# image extra so docker can use aufs storage drivers
apt-get install \
   linux-image-extra-$(uname -r) \
   linux-image-extra-virtual


# package so apt can use https
apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

# add docker gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the docker rep
add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

# install docker-ce
apt-get update

apt-get install docker-ce

# finish up --------------------------------
# ------------------------------------------

mkdir /projects 
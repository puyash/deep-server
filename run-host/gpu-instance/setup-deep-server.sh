#!/bin/bash


apt-get update
apt-get install -y git


# install Docker ---------------------------
# ------------------------------------------

echo "\nInstalling docker ..."

# image extra so docker can use aufs storage drivers
apt-get install -y\
   linux-image-extra-$(uname -r) \
   linux-image-extra-virtual


# package so apt can use https
apt-get install -y\
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
apt-get install -y docker-ce



# install NVIDIA drivers -------------------
# ------------------------------------------

echo "\nInstalling NVIDIA drivers ..."

apt-get install -y curl build-essential

curl -O -s http://us.download.nvidia.com/XFree86/Linux-x86_64/375.39/NVIDIA-Linux-x86_64-375.39.run
sh ./NVIDIA-Linux-x86_64-375.39.run -a --ui=none --no-x-check && rm NVIDIA-Linux-x86_64-375.39.run



# install NVIDIA Docker --------------------
# ------------------------------------------

echo "Installing nvidia-docker."

# get nvidia-docker
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

  
# finish up --------------------------------
# ------------------------------------------

mkdir $HOME/projects

echo "Run: sudo nvidia-docker run --rm nvidia/cuda nvidia-smi"

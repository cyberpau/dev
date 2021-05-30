#!/bin/bash
# Authored by John Paulo Mataac

if [[ $EUID -gt 0 ]]
  then echo "Exiting... Please run as root"
  exit
fi

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
  echo "Starting bootstrap.sh ..."
else
  echo "Unable to connect to internet"
  exit 
fi

## Update and install pre-requisites
sudo yum update -y

## Install Docker Latest Version
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker "$USER"
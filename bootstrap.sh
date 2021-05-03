#!/bin/bash
# Authored by John Paulo Mataac

if [[ $EUID > 0 ]]
  then echo "Exiting... Please run as root"
  exit
fi

## Update and install pre-requisites
sudo yum update -y
sudo yum install -y epel-release git traceroute yum-utils

## IF EXISTS pull dev repo, ELSE clone
if cd dev; then git pull; else git clone https://github.com/cyberpau/dev.git

## Install Ansible
sudo yum install -y ansible

## Install Docker Latest Version
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

## Install Docker Compose v1.29.1 (April 13, 2021)
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## Create Persistent Volumes
mkdir -p ${HOME}/postgres-data/



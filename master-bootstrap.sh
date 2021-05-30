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
sudo yum install -y git traceroute yum-utils net-tools vim

## Install Ansible
sudo yum install -y ansible
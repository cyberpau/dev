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

if cd 1; ## RUN ONLY ONCE!!!!
  then echo "K8 configuration already completed"; 
  else

## Update and install pre-requisites
sudo yum install -y git traceroute yum-utils net-tools epel-release

## Install Ansible
sudo yum install -y ansible

## Install Docker Compose v1.29.1 (April 13, 2021)
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## Finally,
mkdir 1
fi

# # ONLY DO THIS ONCE!!!!

# # kubeadm init --apiserver-advertise-address=192.168.50.100 --pod-network-cidr=192.168.0.0/16

# # mkdir -p $HOME/.kube
# # sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# # sudo chown $(id -u):$(id -g) $HOME/.kube/config


# # # Configure network overlay using Flannel
# # kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# # kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

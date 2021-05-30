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
sudo usermod -aG docker "vagrant"

if cd 0; ## RUN ONLY ONCE!!!!
  then echo "K8 configuration already completed"; 
  else

## Disable and turn off SWAP
swapoff -a; sed -i '/swap/d' /etc/fstab


## Stop and Disable firewall
systemctl disable firewalld; systemctl stop firewalld

## Disable SELinux
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

## Update sysctl settings for Kubernetes networking
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

## Add Kubernetes Yum Repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

## Install Kubernetes Components
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

## Update /etc/hosts file
cat >>/etc/hosts<<EOF
192.168.50.100   kmaster-1.cyberpau.com    kmaster-1
192.168.50.101   kworker-1.cyberpau.com    kworker-1
192.168.50.102   kworker-2.cyberpau.com    kworker-2
EOF

## Enable and start kubelet service
systemctl enable --now kubelet

## Finally,
mkdir 0
fi
# My DEV Environment Setup

![test](https://raw.githubusercontent.com/cyberpau/dev/master/files/images/environment-architecture.png)


## Pre-installation:

- Any web browser (Preferred: MS Edge Browser)
- Any IDE (Preferred: Visual Studio Code)
- IntelliJ (for Java projects only)
- FileZilla (for secure file transfer)
- VirtualBox
- Vagrant 
- Photoshop CS6 (for photo editting)

## Steps:

1. Clone my dev repository: 
    ```
    git clone https://github.com/cyberpau/dev.git
    cd dev
    ```

2. Create the VMs 
    ```
    vagrant up
    ```

2. Login to master node (kmaster-1) and run ansible

<br><br>

# Cheatsheets

## Vagrant

- To get started: `vagrant up`

- List all vagrant machines: `vagrant global-status --prune`

- Destroy a vagrant machine: `vagrant destroy ID_TAG`

- Destroy all: `vagrant destroy -f`


## Ansible

- Install Ansible: `sudo yum install -y epel-release ansible`

- Configure hosts: `sudo vi /etc/ansible/hosts`

- Using ansible ping module for basic connectivity check: `ansible all -m ping`

## Docker

- Kill a container: `docker kill CONTAINER_NAME` and then `docker container prune`. To remove all stopped and dangling containers and networks, run `docker system prune`

- Login to container: `docker exec -it CONTAINER_NAME bash`

- Login to container (detached + rm): `docker exec -it -d --rm CONTAINER_NAME bash`

- Create PostgreSQL container:
`docker run -d --name dev-postgres -e POSTGRES_PASSWORD=mysecretpassword -v ${HOME}/postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres`

- Create MySQL container:
`docker run -d --name dev-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -v ${HOME}/mysql-data/:/var/lib/mysql -p 3306:3306 mysql/mysql-server:latest`

- Create Jenkins container:
`docker run -d --name dev-jenkins -v ${HOME}/jenkins-data/:/var/jenkins_home -p 8082:8080 jenkins/jenkins:lts`. Alternate account: `dev/dev/dev@cyberpau.com`

- Create Kanban container: 
`docker run -d --name kanboard -v ${HOME}/kanboard/kanboard_data:/var/www/app/data -v ${HOME}/kanboard/kanboard_plugins:/var/www/app/plugins -p 8083:80 --restart always -t kanboard/kanboard:v1.2.8`

- Create elk network:
`docker network create elastic`

- Create single-node elasticsearch container:
`docker run -d --name es01-test -v ${HOME}/elasticsearch/:/usr/share/elasticsearch/data --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --restart always docker.elastic.co/elasticsearch/elasticsearch:7.12.1`

- Create kibana container:
`docker run -d --name kib01-test --net elastic -p 5601:5601 -e "ELASTICSEARCH_HOSTS=http://es01-test:9200" docker.elastic.co/kibana/kibana:7.12.1`

- OWASP Glue:
`docker run -d --name owasp-glue -v ${HOME}/owasp/:/src/ owasp/glue OWASPDependencyCheck /src`

- Create Nagios Container:
`docker run -d --name nagios -v ${HOME}/nagios/:/opt/nagios/ -v ${HOME}/nagios-plugin/:/opt/Custom-Nagios-Plugins -p 8080:80 manios/nagios`

## Kubernetes

- Typical k8 post-install check:


- Re-print kubeadm join command: `kubeadm token create --print-join-command`

- Get all pods with labels: `kubectl get pods --show-labels` or `kubectl get pods --selector env=production, 'release-version in (1.0, 2.0)'`

- Delete a label from pod: `kubectl label pod/<pod-name> <label-name>-`

- Get rollout history: `kubectl rollout history deployment`

- Inspect for issues: `kubectl describe <resource> <resource-name>` and `kubectl get logs <pod-name>`, then `kubectl exec -it <pod-name> /bin/bash`.

- Create configmap: `kubectl create configmap <configmap-name> --from-literal=log_level=debug`

- Create secret: `kubectl create secret generic apikey --from-literal=api_key=123456790`

## cAdvisor

## Prometheus

## Powershell v7

- Get powershell version: `Get-Host | Select-Object Version`

- Get listening ports on Windows 10 Powershell: `netstat -ano | findstr :8080`

## PostgreSQL

- Connecting to PostgreSQL Server: `psql -U postgres -p 5432 -h hostname` 

- Create database: `CREATE DATABASE database_name;`

- Create Role: `CREATE ROLE backend WITH LOGIN ENCRYPTED PASSWORD 'mysecretpassword';`

- Give permision to role: `ALTER USER role_specification WITH CREATEDB CREATEROLE CREATEUSER;`

- Give privilege to user on database: `GRANT ALL PRIVILEGES ON DATABASE projectraptor TO backend;`

- Common shortcut commands:
    - List all database: `\l`
    - List all tables: `dt`
    - List all database roles: `\du` 

## MySQL

- Connecting to MySQL Server: `mysql --host=localhost --user=root --password=mysecretpassword`

- Create new user: `CREATE USER 'backend'@'localhost' IDENTIFIED BY 'mysecretpassword';` and drop it using `DROP USER backend;`

- Grant access: `GRANT ALL PRIVILEGES ON * . * TO 'backend'@'localhost';`

- Show grants: `SHOW GRANTS FOR 'backend'@'localhost';`

## Git

![Git Cheatsheat](files\images\git.jpg)
- Untrack changes to file: `git update-index --assume-unchanged src/main/resources/application.properties`

- Show logs oneline: `git log --oneline --all`

## Puppet

- Pull update and deploy: `r10k deploy environment -p`

- Run puppetserver: `puppet agent -t`


## ELK Stack

- Download and install the public signing key: `sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`

- Fix Elasticsearch failed to bind service: `sudo chown 1000:1000 <directory you wish to mount>`

- Kibana config file location: `/etc/kibana/kibana.yml`

- Create `logstash.repo` on /etc/yum.repos.d/:

    ```
    [logstash-7.x]
    name=Elastic repository for 7.x packages
    baseurl=https://artifacts.elastic.co/packages/7.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md
    ```
    
- Enable Filebeat Modules (config file = `/etc/filebeat/filebeat.yml`): 
    ```
    sudo filebeat modules list
    sudo filebeat modules enable system
    ```

## Java

- Install Java: `sudo yum install -y <java version>`
    - OpenJDK 11: `java-11-openjdk`
    - OpenJDK 11 with Java Development Kit: `java-11-openjdk-devel`s
    - OpenJDK 8 with Java Development Kit: `java-1.8.0-openjdk-devel`

## Security and Infrastructure as a Code (IaaC)

- DevSecOps
    1. Design - what do you intent your software to do? Did you make sensitive data secure?
    2. Inherit - What dependencies / libraries / softwares you inherit?
    3. Develop - While you develop, are you writing tests for security?
    4. Build - do you have security acceptance test?
    5. Deploy - What happens to get the software into production? Are you storing config and secrets securely?
    6. Operate - Are you under active attack at this moment? What is getting attacked?

- Websites:
    -  [National Vulnerability Database](https://nvd.nist.gov/)

- Thread Modelling:
    - OWASP App Threat Modeling Cheat Sheet
    - OWASP Application Security Verification Standard
    - Mozilla Rapid Risk Assesment
    - OWASP Dependency Check

- Security Applications
    - Find Sec Bugs (For Java applications)
    - OWASP Zed Attack Proxy (Dynamic Vulnerability Scanner)
    - SQLMap (SQL Injection)
    - OpenVAS (Vulnerability Scanner)
    - Recon-Ng (Searches for exposed codes)
    - OWASP Glue Tool Project 
    - Contrast RASP (Continuous Monitoring)
    - Clair (Container Scanner)
    - Gauntlt
    - git-hound
    - git-secrets
    - Arachni
    - Nikto
    - ZAP
    - Burp Suite
    - SqlMap
    - SSLScan
    - SSLyze
    - Arachni-scanner

- Formatters
    - Rubocop

- Linters
    - Foodcritic (Chef)

- Integration
    - Serverspec
    - Inspec (inspec.io)

- Bug Bounties
    - Bugcrowd
    - HackerOne

- RASP and next-gen WAF (Runtime Defense)
    - ModSecurity + ELK + StatsD
    - Commercial Options:
        - Contrast
        - Prevoty
        - Signal Sciences
        - tCell
        - Waratek

- Cloud Security Monitoring:
    - AWS Config + AWS CloudTrail + Amazon Inspector + AWS GuardDuty
    - ThreatStack
    - AlienVault
    - Evident.io

## Chef

- Install Chef: `curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -P chefdk -c stable`

- Get version `chef --version`

- Run chef locally: `sudo chef-client -z hello.rb`


## Linux

- Make file executable: `chmod +x filename.sh`

- Generate and use SSH keys:
    - `ssh-keygen -t ed25519 -C "<comment>"` for ED25519 or `ssh-keygen -t rsa -b 2048 -C "<comment>"` for 2048-bit RSA
    - Copy ssh public key to remote machine: `ssh-copy-id demo@198.51.100.0`
    - disable password for root login: `sudo nano /etc/ssh/sshd_config` and modify to `PermitRootLogin without-password`

- Check for netstat port forwarding: `netstat -tulpn | grep 9200`

- Enable dhcp client `dhclient -v`

- Important Linux File Directories:

    ![Linux File Directory](https://github.com/cyberpau/dev/blob/88a603f2ece178f519b86ca0a2714846d725c8c3/files/images/linux-file-dir.jpg?raw=true)
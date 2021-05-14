# My DEV Environment Setup

![test](files\images\environment-architecture.png)

<br><br>

# Cheatsheets

## Vagrant

- To get started: `vagrant up`

- List all vagrant machines: `vagrant global-status --prune`

- Destroy a vagrant machine: `vagrant destroy ID_TAG`


## Ansible

- Using ansible ping module for basic connectivity check: `ansible all -m ping`

## Docker

- Kill a container: `docker kill CONTAINER_NAME` and then `docker container prune`

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

- Untrack changes to file: `git update-index --assume-unchanged src/main/resources/application.properties`

- Show logs oneline: `git log --oneline --all`

## Puppet

- Pull update and deploy: `r10k deploy environment -p`

- Run puppetserver: `puppet agent -t`

## Linux

- Make file executable: `chmod +x filename.sh`

- Generate and use SSH keys:
    - `ssh-keygen -t ed25519 -C "<comment>"` for ED25519 or `ssh-keygen -t rsa -b 2048 -C "<comment>"` for 2048-bit RSA
    - Copy ssh public key to remote machine: `ssh-copy-id demo@198.51.100.0`
    - disable password for root login: `sudo nano /etc/ssh/sshd_config` and modify to `PermitRootLogin without-password`


- Important Linux File Directories:

    ![Linux File Directory](https://github.com/cyberpau/dev/blob/88a603f2ece178f519b86ca0a2714846d725c8c3/files/images/linux-file-dir.jpg?raw=true)
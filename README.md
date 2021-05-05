# My DEV Environment Setup

**Host Environment**
- IntelliJ IDE
- Visual Studio Code
- Powershell v7
- Git

**Virtual Machine Environment**
- Vagrant
- Ansible
- Docker

<br>

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

## Powershell v7

- Get powershell version: `Get-Host | Select-Object Version`

- Get listening ports on Windows 10 Powershell: `netstat -ano | findstr :8080`

## PostgreSQL

- Connecting to PostgreSQL Server: `psql -U postgres -p 5432 -h hostname` 

- Create database: `CREATE DATABASE database_name;` and `\l` to get list of all databases.

- Create Role: `CREATE ROLE backend WITH LOGIN ENCRYPTED PASSWORD 'mysecretpassword';` and `\du` to get list of all database roles

- Give permision to role: `ALTER USER role_specification WITH CREATEDB CREATEROLE CREATEUSER;`

- Give privilege to user on database: `GRANT ALL PRIVILEGES ON DATABASE projectraptor TO backend;`

## MySQL

- Connecting to MySQL Server: `mysql --host=localhost --user=root --password=mysecretpassword`

- Create new user: `CREATE USER 'backend'@'localhost' IDENTIFIED BY 'mysecretpassword';` and drop it using `DROP USER backend;`

- Grant access: `GRANT ALL PRIVILEGES ON * . * TO 'backend'@'localhost';`

- Show grants: `SHOW GRANTS FOR 'backend'@'localhost';`

## Git

- Untrack changes to file: `git update-index --assume-unchanged src/main/resources/application.properties`

## Linux

- Make file executable: `chmod +x filename.sh`

- Add executable to user bash profile:

- Important Linux File Directories:

    ![Linux File Directory](files\images\linux-file-dir.jpg)
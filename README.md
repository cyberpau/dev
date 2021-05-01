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
`docker run -d --name CONTAINER_NAME -e POSTGRES_PASSWORD=mysecretpassword -v ${HOME}/postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres`


## Powershell v7 LTS

- Get powershell version: `Get-Host | Select-Object Version`

- Get listening ports on Windows 10 Powershell: `netstat -ano | findstr :8080`

## PostgreSQL

- Connecting to PostgreSQL Server: `psql -U postgres -p 5432 -h hostname`

- Create Role: `CREATE ROLE cyberpau WITH LOGIN ENCRYPTED PASSWORD 'secret_password';`

- Give permision to role: `ALTER USER role_specification WITH CREATEDB CREATEROLE CREATEUSER;`

- Give privilege to user on database: `GRANT ALL PRIVILEGES ON DATABASE "database_name" TO cyberpau;`

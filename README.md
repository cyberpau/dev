# My DEV Environment Setup

Quicklinks:
https://start.spring.io/


This DEV environment is bundled with the following tools:
- Vagrant
- Ansible
- Docker

## Vagrant

To get started: `vagrant up`

List all vagrant machines: `vagrant global-status --prune`

Destroy a vagrant machine: `vagrant destroy ID_TAG`


## Ansible Cheatsheet


## Docker Cheatsheet

Kill a container: `docker kill CONTAINER_NAME` and then `docker container prune`

Login to container: `docker exec -it CONTAINER_NAME bash`

Login to container (detached + rm): `docker exec -it -d --rm CONTAINER_NAME bash`

Create PostgreSQL container: 
`docker run -d --name CONTAINER_NAME -e POSTGRES_PASSWORD=mysecretpassword -v ${HOME}/postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres`


## Powershell v7 LTS

Get powershell version: `Get-Host | Select-Object Version`

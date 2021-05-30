IMAGE_NAME = "centos/7"
K8S_CLUSTER_NAME = "k8s-dev-cluster"

MASTERS_NAME = "kmaster-"
MASTERS_NUM = 1
MASTERS_CPU = 2 
MASTERS_MEM = 2048

WORKER_NAME = "kworker-"
NODES_NUM = 2
NODES_CPU = 1
NODES_MEM = 1024

IP_BASE = "192.168.50."

VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    
    ## Provision Master Nodes -------------------------
    (1..MASTERS_NUM).each do |i|      
        config.vm.define "#{MASTERS_NAME}#{i}" do |master|
            master.vm.box = IMAGE_NAME
            master.vm.network "private_network", ip: "#{IP_BASE}#{i + 99*i}"
            master.vm.hostname = "#{MASTERS_NAME}#{i}"
            master.vm.provider "virtualbox" do |v|
                v.memory = MASTERS_MEM
                v.cpus = MASTERS_CPU
            end
            config.vm.provision "shell", path: "bootstrap.sh"
            config.vm.provision "shell", path: "master-bootstrap.sh"
        end
    end

    ## Provision Worker Nodes -------------------------
    (1..NODES_NUM).each do |j|
        config.vm.define "#{WORKER_NAME}#{j}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "#{IP_BASE}#{j + 100}"
            node.vm.hostname = "#{WORKER_NAME}#{j}"
            node.vm.provider "virtualbox" do |v|
                v.memory = NODES_MEM
                v.cpus = NODES_CPU
            end
            config.vm.provision "shell", path: "bootstrap.sh"
            config.vm.provision "shell", path: "worker-bootstrap.sh"
        end
    end
end
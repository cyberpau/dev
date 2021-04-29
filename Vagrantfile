CPUS="2"
MEMORY="4096"

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.hostname = "dev.cyberpau.vm"

  # Install Docker / Docker Compose
  config.vm.provision :docker

  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.name = "dev.cyberpau.vm"
    v.memory = MEMORY
    v.cpus = CPUS
  end

end

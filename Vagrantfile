CPUS="2"
MEMORY="4096"

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.hostname = "dev.cyberpau.vm"

  # Install Docker / Docker Compose
  config.vm.provision :docker

  # Run bootstrap
  config.vm.provision "shell", path: "bootstrap.sh"

  # Enable port-forwarding
  # config.vm.network :forwarded_port, host: 5432, guest: 5432

  config.vm.provider "virtualbox" do |v|
    v.name = "dev.cyberpau.vm"
    v.memory = MEMORY
    v.cpus = CPUS
  end

end

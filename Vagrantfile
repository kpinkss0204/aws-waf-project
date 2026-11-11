# -*- mode: ruby -*-
# vi: set ft=ruby

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  ### Ubuntu Node ###
  config.vm.define "ubuntu-vm" do |cfg|
    cfg.vm.box = "ubuntu/jammy64"
    cfg.vm.provider "virtualbox" do |vb|
      vb.name = "UBUNTU-VM"
      vb.cpus = 1
      vb.memory = 1024
      vb.gui = false
    end
    cfg.vm.host_name = "ubuntu-vm"
    cfg.vm.network "private_network", ip: "192.168.100.10"
    cfg.vm.network "forwarded_port", guest: 22, host: 60010, auto_correct: true, id: "ssh"
    cfg.vm.synced_folder "../data", "/vagrant", disabled: true
    cfg.vm.provision "shell", path: "terraform_install.sh", privileged: true
  end
end
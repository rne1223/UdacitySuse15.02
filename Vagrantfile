# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

ENV["TERM"]="linux"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# set the image for the vagrant box
	config.vm.box = "opensuse/Leap-15.2.x86_64"

	config.vm.provision "shell" , path: "./bootstrap.sh"

    config.vm.define "default" do |default|
       default.vm.hostname = "UdacitySuse15.02"
    end

	# consifure the parameters for VirtualBox provider
	config.vm.provider "virtualbox" do |vb|
		vb.memory = "4096"
		vb.cpus = 4
		vb.customize ["modifyvm", :id, "--ioapic", "on"]
	end

  	# st the static IP for the vagrant box
  	config.vm.network "private_network", ip: "192.168.50.4"
end

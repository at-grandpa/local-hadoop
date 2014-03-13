# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  config.vm.box     = "ubuntu13.04_amd64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"


  config.omnibus.chef_version = "11.10.2"


  config.vm.network :private_network, ip: "192.168.33.10"


  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end


  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./site-cookbooks/"]
    chef.run_list = ["hadoop"]
  end


end

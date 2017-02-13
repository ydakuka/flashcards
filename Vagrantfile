# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.1"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 3000, host: 1361
  config.vm.network "private_network", ip: "10.11.12.14"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.synced_folder "puppet/environments/mkdev/hieradata", "/etc/puppet/hieradata"
  # config.vm.synced_folder "puppet/environments/mkdev/files", "/etc/puppet/files"

  config.vm.provider "virtualbox" do |vb|
    vb.gui    = false
    vb.memory = "2048"
  end

  ## Set up proxy if there is one in the environment
  # if ENV['http_proxy'] && ENV['https_proxy']
  #   htp = ENV['http_proxy']
  #   htps = ENV['https_proxy']
  #   config.vm.provision "shell", :inline => "echo export http_proxy=#{htp} >> ~/.bashrc"
  #   config.vm.provision "shell", :inline => "echo export https_proxy=#{htps} >> ~/.bashrc"
  # end

  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  config.vbguest.auto_update = false
  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = true

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./chef/site-cookbooks/main/Berksfile"

  config.vm.provision "chef_solo" do |chef|
    # chef.version      = "12.18.31"
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.nodes_path     = "chef/nodes"
    chef.roles_path     = "chef/roles"
    chef.cookbooks_path = "chef/cookbooks"
    chef.data_bags_path = "chef/data_bags"
    # chef.environments_path = "chef/environments"

    # chef.add_role "website"
    # chef.json = {
    #   rbenv: {
    #     user_installs: [{
    #       user: 'vagrant',
    #       rubies: ["2.3.3"],
    #       global: "2.3.3",
    #       gems: {
    #         "2.3.3" => [
    #           { name: "bundler" }
    #         ]
    #       }
    #     }]
    #   }
    # }
  end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

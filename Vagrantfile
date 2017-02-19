# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.1"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 3000, host: 1367
  config.vm.network "private_network", ip: "10.11.12.14"
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    vb.gui    = false
    vb.memory = "2048"
  end

  # if Vagrant.has_plugin?("vagrant-omnibus")
  #   config.omnibus.chef_version = :latest
  # end

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end

  if Vagrant.has_plugin?("vagrant-berkshelf")
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "./site-cookbooks/main/Berksfile"
  end

  config.vm.provision "chef_solo" do |chef|
    # chef.version      = "12.18.31"
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.nodes_path     = "nodes"
    chef.roles_path     = "roles"
    chef.cookbooks_path = "cookbooks"
    chef.data_bags_path = "data_bags"
    # chef.environments_path = "environments"

    chef.add_recipe "vim"
    chef.add_recipe "apt"
    chef.add_recipe "ruby_build"
    chef.add_recipe "nodejs::nodejs_from_package"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "runit"

    chef.json = {
      nodejs: {
        version: 'latest'
      },
      postgresql: {
        password: {
          "postgres" => "password"
        },

        run_list: ["recipe[postgresql::server]"]
      }
    }

    chef.add_recipe "main"
  end
end

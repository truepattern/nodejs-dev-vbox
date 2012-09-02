# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  #config.vm.share_folder "v-root", "/vagrant", "."
  config.vm.share_folder "app", "/home/vagrant/app", "app"
  config.vm.host_name = "dev-nodejs"

  # allow for symlinks in the app folder
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/app", "1"]
  config.vm.customize do |vm|
    vm.memory_size = 1024
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|

    # chef config
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"
    chef.log_level = :info
    #chef.log_level = :debug

    # add roles
    chef.add_role("db_master")
    chef.add_role("webserver")

    # add mysite to webserver
    chef.add_recipe("mysite")
    chef.add_recipe("mysite::node")

    # add node.js
    chef.add_recipe "nodejs"

    # receipe config
    chef.json = {
      "nodejs" => {
        :install_method => "package"
      }    	      
    }

  end

end

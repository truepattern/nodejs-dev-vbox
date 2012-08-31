# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 8080, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder "app", "/home/vagrant/app", "app"
  # allow for symlinks in the app folder
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/app", "1"]

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "apt"
    chef.add_recipe "git"
    chef.add_recipe "nodejs"
    chef.add_recipe "mongodb::10gen_repo"
    chef.add_recipe "mongodb::default"
    chef.json = {
      "nodejs" => {
        :install_method => "package"
      }    	      
    }
  end

end

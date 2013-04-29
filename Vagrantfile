# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

  #The first parameter is a path to a directory on the host machine. If
  #the path is relative, it is relative to the project root. The second
  #parameter must be an absolute path of where to share the folder within
  #the guest machine. This folder will be created (recursively, if it
  #must) if it doesn't exist
  #config.vm.synced_folder "src/", "/srv/website"
  config.vm.synced_folder "app", "/home/vagrant/app"

  config.vm.provider :virtualbox do |v|
    # Setting VM name and increasing RAM size
    v.customize [
      "modifyvm", :id,
      "--memory", "1024",
      "--name"  , "devnodejs"
    ]
    # Boot with a GUI so you can see the screen. (Default is headless)
    # v.gui = true

    # without this symlinks can't be created on the shared folder
    v.customize [
      "setextradata", :id,
      "VBoxInternal2/SharedFoldersEnableSymlinksCreate/app", "1"
    ]
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
    chef.add_role("monit")

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

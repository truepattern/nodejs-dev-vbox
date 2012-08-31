Dev setup for Node.js with MongoDB. Based on VirtualBox, Ubuntu 12.04, Vagrant and Chef

## Literature & Pre-requisite
Please go thru the following links and setup these tools before proceeding
  * VirtualBox from Oracle (virtualbox.org)
  * Vagrant (vagrantup.com)

## Setup
  > vagrant box add precise64 http://files.vagrantup.com/precise64.box
  > git clone https://github.com/truepattern/nodejs-dev-vbox.git mynodejs
  > cd mynodejs
  > vagrant up

### Packages
Following software are installed 
  * git
  * nodejs
  * mongodb

### Console
  * vagrant ssh 

### Node.js App
  * The sample app is in 'app' directory 
  * ssh to virtualbox
    > cd app
    > node server.js
  * go to your host box, browser and try http://localhost:8080


## Notes
You can use this to bootstrap your node development, or copy the cookbooks and Vagrantfile to your existing node.js setup

## License
Please refer to the cookbooks for their respective licenses (mostly Apache). 

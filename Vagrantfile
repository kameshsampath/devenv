# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

BOX_NAME = ENV['BOX_NAME'] || "chef/centos-6.5"  #"ubuntu/trusty64" 
SSH_PRIVKEY_PATH = ENV["SSH_PRIVKEY_PATH"] || "~/.vagrant.d/insecure_private_key"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Detects vagrant-cachier plugin
  if Vagrant.has_plugin?('vagrant-cachier')
    puts 'INFO:  Vagrant-cachier plugin detected. Optimizing caches.'
    config.cache.scope = :box
    config.cache.auto_detect = true
    config.cache.enable :chef
  else
    puts 'WARN:  Vagrant-cachier plugin not detected. Continuing unoptimized.'
  end

  # Detects vagrant-omnibus plugin
  if Vagrant.has_plugin?('vagrant-omnibus')
    puts 'INFO:  Vagrant-omnibus plugin detected.'
    config.omnibus.chef_version = :latest
  else
    puts "FATAL: Vagrant-omnibus plugin not detected. Please install the plugin with\n       'vagrant plugin install vagrant-omnibus' from any other directory\n       before continuing."
    exit
  end

  # Detects vagrant-berkshelf plugin
  if Vagrant.has_plugin?('berkshelf')
    config.berkshelf.enabled = true
    puts 'INFO:  Vagrant-berkshelf plugin detected.'
    config.berkshelf.berksfile_path = 'Berksfile'
  else
     puts "FATAL: Vagrant-berkshelf plugin not detected. Please install the plugin with\n       'vagrant plugin   install vagrant-berkshelf' from any other directory\n       before continuing."
     exit
  end

  config.vm.box = BOX_NAME 
  
  config.vm.network :forwarded_port, guest: 8081, host: 8081, auto_correct: true
  config.vm.synced_folder "~/sonatype-work", "/usr/local/sonatype-work", create: true

  # Use the specified private key path if it is specified and not empty.
  if SSH_PRIVKEY_PATH
      config.ssh.forward_agent = true
      config.ssh.private_key_path = "#{SSH_PRIVKEY_PATH}"
    else
       config.ssh.username = 'vagrant'
       config.ssh.password = 'vagrant'
  end

  #Provision the box
  config.vm.provision "chef_solo" do | chef|
    chef.environments_path = "environments"
    chef.environment="vagrant"
    chef.roles_path = ["roles"]
    chef.add_role("nexus-standalone")  

  end

  # VirtualBox configuration
  config.vm.provider "virtualbox" do |vbox|
    vbox.name  = "devenv"
    vbox.memory = 2048
  end

  ## Firewall

  if BOX_NAME =~ /ubuntu/ 

     config.vm.provision "shell", path: "scripts/ubuntu_firewall_rules.sh"

  elsif BOX_NAME =~ /centos/

    config.vm.provision "shell", path: "scripts/rhel_firewall_rules.sh"

  end

  ## End of Firewall
 end

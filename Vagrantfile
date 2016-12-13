# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "opscode-ubuntu-14.04"
   # if you are behing corporate firewall
   # step1: install vagrant-proxyconf plugin `$ vagrant plugin install vagrant-proxyconf
   # step2: uncomment below configuration
   # if Vagrant.has_plugin?("vagrant-proxyconf")
   #  config.proxy.http     = "http://172.21.4.10:3128/"
   #  config.proxy.https    = "http://172.21.4.10:3128/"
   #  config.proxy.no_proxy = "localhost,127.0.0.1"
   # end


  config.vm.provision :shell, :inline => "sudo apt-get update -y"

  config.vm.provision :shell, :inline => "sudo apt-get install git vim ntp -y"

  config.vm.provision :shell, :inline => "sudo service ntp restart"

  # config.vm.provision :shell, :inline => "wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb >/dev/null 2>&1"


  # config.vm.provision :shell, :inline => "sudo dpkg -i puppetlabs-release-pc1-trusty.deb >/dev/null 2>&1"

  # config.vm.provision :shell, :inline => "sudo apt-get update -y >/dev/null 2>&1"

   config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048] 
    # vb.gui = true
   end

   config.vm.define :puppetmaster do |vm_config|

    vm_config.vm.network "private_network", ip: "192.168.50.4"
    vm_config.vm.hostname = "puppetmaster.arris.com"
    vm_config.vm.network "forwarded_port", guest: 8140, host: 8140
    vm_config.vm.network "forwarded_port", guest: 8000, host: 8000

   end

   config.vm.define :puppet_agent do |vm_config|
    vm_config.vm.network "private_network", ip: "192.168.50.5"
    vm_config.vm.hostname = "puppet-agent.arris.com"
   end

end













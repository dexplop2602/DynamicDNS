# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.define "dns" do |dns|
    dns.vm.hostname = "dns"
    dns.vm.network "private_network",
      ip: "192.168.58.10",
      virtualbox__intnet: "ddns_lab_network",
      virtualbox__dhcp: false
    dns.vm.provision "shell", path: "dns-provision.sh"
  end

  config.vm.define "dhcp" do |dhcp|
    dhcp.vm.hostname = "dhcp"
    dhcp.vm.network "private_network",
      ip: "192.168.58.20",
      virtualbox__intnet: "ddns_lab_network"
    dhcp.vm.provision "shell", path: "dhcp-provision.sh"
  end

  config.vm.define "c1" do |c1|
    c1.vm.hostname = "c1"
    c1.vm.network "private_network",
      type: "dhcp",
      virtualbox__intnet: "ddns_lab_network"
    c1.vm.provision "shell", path: "client-provision.sh"
  end
end
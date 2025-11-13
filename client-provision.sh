#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install dnsutils
cp /vagrant/configs/dhclient.conf /etc/dhcp/dhclient.conf
systemctl restart systemd-networkd.service
#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install isc-dhcp-server
echo 'INTERFACESv4="enp0s8"' > /etc/default/isc-dhcp-server
cp /vagrant/ddns.key /etc/dhcp/ddns.key
cp /vagrant/configs/dhcpd.conf /etc/dhcp/dhcpd.conf

systemctl restart systemd-networkd.service
sleep 3

systemctl restart isc-dhcp-server

systemctl status isc-dhcp-server --no-pager || true


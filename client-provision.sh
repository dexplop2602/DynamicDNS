#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install dnsutils

cat <<EOF > /etc/dhcp/dhclient.conf
send host-name = gethostname();
EOF

dhclient -r enp0s8
dhclient enp0s8
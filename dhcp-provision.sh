#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install isc-dhcp-server

# 1. Configurar la interfaz de red
echo 'INTERFACESv4="enp0s8"' > /etc/default/isc-dhcp-server

# 2. Copiar la clave generada por el servidor DNS y el archivo de configuración
cp /vagrant/ddns.key /etc/dhcp/ddns.key
cp /vagrant/configs/dhcpd.conf /etc/dhcp/dhcpd.conf

# 3. Reiniciar el servicio
systemctl restart isc-dhcp-server
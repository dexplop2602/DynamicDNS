#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install bind9 bind9utils

# 1. Generar la clave y extraer el secreto
tsig-keygen -a hmac-sha256 ddns-key > /etc/bind/ddns.key
chown bind:bind /etc/bind/ddns.key
DDNS_SECRET=$(grep secret /etc/bind/ddns.key | cut -d '"' -f 2)

# 2. Copiar archivos de configuración desde el host
cp /vagrant/configs/named.conf.options /etc/bind/named.conf.options
cp /vagrant/configs/named.conf.local /etc/bind/named.conf.local
cp /vagrant/configs/db.example.test /var/lib/bind/db.example.test
cp /vagrant/configs/db.192 /var/lib/bind/db.192

# 3. Inyectar el secreto dinámico en el archivo de opciones
sed -i "s/SECRET_PLACEHOLDER/$DDNS_SECRET/" /etc/bind/named.conf.options

# 4. Establecer permisos y reiniciar
chown bind:bind /var/lib/bind/db.example.test /var/lib/bind/db.192
cp /etc/bind/ddns.key /vagrant/ddns.key
named-checkconf
systemctl restart bind9
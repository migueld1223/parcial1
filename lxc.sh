#!/bin/bash
echo "Carga lxd"
sudo snap install lxd --channel=4.0/stable
echo "Ingresa al grupo"
newgrp lxd
echo "Inicializa"
lxd init --auto
echo "Carga ubuntu"
lxc init ubuntu:20.04 balancerha --target  servidorUbuntu1
echo "Inicia balancerha"
lxc start balancerha
echo "Actualiza balancerha"
lxc exec balancerha -- apt update -y
lxc exec balancerha -- apt upgrade -y
echo "Instala haproxy"
lxc exec balancerha -- apt install haproxy
echo "Carga haproxy"
lxc exec balancerha -- enable haproxy
echo "Carga cfg"
lxc file push /vagrant/haparc1.cfg balancerha/etc/haproxy/haproxy.cfg
echo "Cambio mensaje error"
lxc file push /vagrant/indexh.http balancerhaproxyy/etc/haproxy/errors/503.http
echo "Re inicia haproxy"
lxc exec balancerha -- systemctl restart haproxy
echo " Redireccionamiento de puerto"
lxc config device add balancerha http proxy listen=tcp:192.168.100.14:2580 connect=tcp:127.0.0.1:80
#!/bin/bash
echo "Carga lxd"
sudo snap install lxd --channel=4.0/stable
echo "Ingresa al grupo"
newgrp lxd
echo "Inicializa"
lxd init --auto
echo "Carga ubuntu"
lxc init ubuntu:20.04 web2 --target servidorUbuntu2
echo "Inicia web2"
lxc start web2
sleep 30s
echo "Actualiza web2"
lxc exec web2 -- apt update -y
lxc exec web2 -- apt upgrade -y
lxc exec web2 -- apt install apache2 -y
echo "Carga apache"
lxc exec web2 -- systemctl enable apache2
echo "Carga html"
lxc file push /vagrant/index1.html web2/var/www/html/index.html
echo "Inicia web2"
lxc exec web2 -- systemctl restart apache2
#echo "Reinicia sys"
#lxc exec back2 -- systemctl restart apache2
#echo "Válida ip"
#curl 240.16.0.128
echo " Redireccionamiento de puerto"
lxc config device add web2 myport80 proxy listen=tcp:192.168.100.15:80 connect=tcp:127.0.0.1:80

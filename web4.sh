#!/bin/bash
echo "Carga lxd"
sudo snap install lxd --channel=4.0/stable
echo "Ingresa al grupo"
newgrp lxd
echo "Inicializa"
lxd init --auto
echo "Carga ubuntu"
lxc init ubuntu:18.04 web4 --target servidorUbuntu2
echo "Inicia web4"
lxc start web4
sleep 30s
echo "Actualiza web4"
lxc exec web4 -- apt-get update -y
lxc exec web4 -- apt-get upgrade -y
lxc exec web4 -- apt-get install apache2 -y
echo "Carga apache"
lxc exec web4 -- systemctl enable apache2
echo "Carga html"
lxc file push /vagrant/index2.html web4/var/www/html/index.html
echo "Inicia web4"
lxc exec web4 -- systemctl start apache2
#echo "Reinicia sys"
#lxc exec back2 -- systemctl restart apache2
#echo "Válida ip"
#curl 240.16.0.128
echo " Redireccionamiento de puerto"
lxc config device add web4 myport8080 proxy listen=tcp:192.168.100.15:8080 connect=tcp:127.0.0.1:80
echo "Instala Backup"
echo "Carga ubuntu"
lxc init ubuntu:18.04 back4 --target servidorUbuntu2
echo "Inicia back4"
lxc start back4
sleep 30s
echo "Actualiza back4"
lxc exec back4 -- apt-get update -y
lxc exec back4 -- apt-get upgrade -y
lxc exec back4 -- apt-get install apache2 -y
echo "Carga apache"
lxc exec back4 -- systemctl enable apache2
echo "Carga html"
lxc file push /vagrant/indexb3.html back4/var/www/html/index.html
echo "Inicia back4"
lxc exec back4 -- systemctl start apache2
#echo "Reinicia sys"
#lxc exec back2 -- systemctl restart apache2
#echo "Válida ip"
#curl 240.16.0.128
echo " Redireccionamiento de puerto"
lxc config device add back4 myport8055 proxy listen=tcp:192.168.100.15:8055 connect=tcp:127.0.0.1:80
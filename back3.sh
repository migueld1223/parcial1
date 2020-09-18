#!/bin/bash
echo "Carga ubuntu"
lxc init ubuntu:20.04 back3 --target servidorUbuntu3
echo "Inicia back3"
lxc start back3
sleep 30s
echo "Actualiza back3"
lxc exec back3 -- apt update -y
lxc exec back3 -- apt upgrade -y
lxc exec back3 -- apt install apache2 -y
echo "Carga apache"
lxc exec back3 -- systemctl enable apache2
echo "Carga html"
lxc file push /vagrant/indexb3.html back3/var/www/html/index.html
echo "Inicia back3"
lxc exec back3 -- systemctl start apache2
#echo "Reinicia sys"
#lxc exec back2 -- systemctl restart apache2
#echo "Válida ip"
#curl 240.16.0.149
echo " Redireccionamiento de puerto"
lxc config device add balancerha http proxy listen=tcp:192.168.100.16:2580 connect=tcp:127.0.0.1:80


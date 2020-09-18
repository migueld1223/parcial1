#!/bin/bash
echo "Carga ubuntu"
lxc init ubuntu:20.04 back2 --target servidorUbuntu2
echo "Inicia back2"
lxc start back2
sleep 30s
echo "Actualiza back2"
lxc exec back2 -- apt update -y
lxc exec back2 - apt upgrade -y
lxc exec back2 -- apt install apache2 -y
echo "Carga apache"
lxc exec back2 -- systemctl enable apache2
echo "Carga html"
lxc file push /vagrant/indexb2.html back2/var/www/html/index.html
echo "Inicia back2"
lxc exec back2 -- systemctl start apache2
#echo "Reinicia sys"
#lxc exec back2 -- systemctl restart apache2
#echo "Válida ip"
#curl 240.15.0.233
echo " Redireccionamiento de puerto"
lxc config device add back2 myport8056 proxy listen=tcp:192.168.100.15:8056 connect=tcp:127.0.0.1:80
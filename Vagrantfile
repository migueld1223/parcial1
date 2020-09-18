
Vagrant.configure("2") do |config|
config.vm.define :servidorUbuntu1 do |servidorUbuntu1|
servidorUbuntu1.vm.box = "bento/ubuntu-20.04"
servidorUbuntu1.vm.network :private_network, ip: "192.168.100.14"
servidorUbuntu1.vm.provision "shell", path: "lxc.sh"
servidorUbuntu1.vm.hostname = "servidorUbuntu1"
end
config.vm.define :servidorUbuntu2 do |servidorUbuntu2|
servidorUbuntu2.vm.box = "bento/ubuntu-20.04"
servidorUbuntu2.vm.network :private_network, ip: "192.168.100.15"
servidorUbuntu2.vm.provision "shell", path: "web2.sh"
servidorUbuntu2.vm.provision "shell", path: "back2.sh"
servidorUbuntu2.vm.provision "shell", path: "web4.sh"
servidorUbuntu2.vm.hostname = "servidorUbuntu2"
end 
#config.vm.define :servidorUbuntu3 do |servidorUbuntu3|
#servidorUbuntu3.vm.box = "bento/ubuntu-20.04"
#servidorUbuntu3.vm.network :private_network, ip: "192.168.100.16"
#servidorUbuntu3.vm.provision "shell", path: "web3.sh"
#servidorUbuntu2.vm.provision "shell", path: "back3.sh"
#servidorUbuntu3.vm.hostname = "servidorUbuntu3"  
#end
end
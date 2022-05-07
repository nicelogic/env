
#!/bin/sh


#--

myFile="/root/env/config.yml"
if [ ! -f "$myFile" ]; then
  touch "$myFile"
fi

echo -n "input node name: "
export NODE_NAME=node-0
echo -n "input local ip: "
export LOCAL_IP=192.168.1.100

#--

hostnamectl set-hostname ${NODE_NAME}
sed -i 's/^127.0.1.1 .*$/127.0.1.1 '${NODE_NAME}'/' /etc/hosts



#--

eth0Info=`ifconfig eth0`
isEth0Configured=$(echo $eth0Info | grep "eth0: flags")
if [[ "$isEth0Configured" != "" ]]
then
	echo "eth0 has configured"
else 
	echo "eth0 not configured"
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
tee /etc/netplan/00-installer-config.yaml  <<EOF
network:
  ethernets:
    eth0:
      dhcp4: no
      dhcp6: no
      addresses: [$LOCAL_IP/24]
      gateway4: 192.168.1.1
      nameservers:
              addresses: [114.114.114.114, 8.8.8.8]
  version: 2
EOF
netplan apply
update-grub
reboot

fi


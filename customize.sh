
#!/bin/sh


#--

# nodeName=`head -n 1 config.yml`
# initNodeName='node-name: ""'
# if [[ "$nodeName" == "$initNodeName" ]] 
# then
# 	echo "node-name not config"
# 	echo -n "input node name: "
# 	read nodeName
# 	sed -i "s/node-name: \"\"/node-name: \""$nodeName"\"/" config.yml
# else
# 	echo ${nodeName}
# fi

# localIp=`head -n 2 config.yml | tail -n 1`
# initLocalIp='local-ip: ""'
# if [[ "$localIp" == "$initLocalIp" ]] 
# then
# 	echo "local ip not config"
# 	echo -n "input local ip: "
# 	read localIp
# 	sed -i "s/local-ip: \"\"/local-ip: \""$localIp"\"/" config.yml
# else
# 	echo ${localIp}
# fi

export NODE_NAME=$1
export LOCAL_IP=$2

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



#!/bin/sh

export LOCAL_IP=$1
echo "in shell, local ip: $LOCAL_IP"

eth0Info=`ifconfig eth0`
isEth0Configured=$(echo $eth0Info | grep "eth0: flags")
if [[ "$isEth0Configured" != "" ]]
then
	echo "eth0 has configured"
else 
	echo "eth0 not configured"
  sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
  update-grub
  reboot
fi

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


#!/bin/sh

export LOCAL_IP=$1
export NETWORK_INTERFACE_CARD=$2
export LOCAL_IP_GATEWAY=$3
export NETPLAN_CONFIG_FILE_PATH=$4
echo "local ip: $LOCAL_IP"
echo "network interface card: $NETWORK_INTERFACE_CARD"
echo "local ip gateway: $LOCAL_IP_GATEWAY"
echo "netplan config file path: $NETPLAN_CONFIG_FILE_PATH"

# eth0Info=`ifconfig eth0`
# isEth0Configured=$(echo $eth0Info | grep "eth0: flags")
# if [ "$isEth0Configured" != "" ]; then
# 	echo "eth0 has configured"
# else 
# 	echo "eth0 not configured"
#   sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
#   update-grub
#   reboot
# fi

tee $NETPLAN_CONFIG_FILE_PATH <<EOF
network:
  version: 2
  ethernets:
    $NETWORK_INTERFACE_CARD:
      dhcp4: no
      dhcp6: no
      addresses: [$LOCAL_IP/24]
      gateway4: $LOCAL_IP_GATEWAY
      nameservers:
              addresses: [114.114.114.114, 8.8.8.8]
EOF
netplan apply


# This is the network config written by 'subiquity'
network:
  version: 2
  wifis:
    wlp2s0:
      access-points:
        ice:
          password: Niceice220
      #dhcp4: true
      dhcp4: no
      dhcp6: no
      addresses: [192.168.1.101/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [114.114.114.114, 8.8.8.8]

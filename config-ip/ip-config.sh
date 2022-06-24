#!/bin/bash

export LOCAL_IP=$1
export NETWORK_INTERFACE_CARD=$2
export LOCAL_IP_GATEWAY=$3
export NETPLAN_CONFIG_FILE_PATH=$4
export WIFI_NAME=$5
export WIFI_PWD=$6
echo "local ip: $LOCAL_IP"
echo "network interface card: $NETWORK_INTERFACE_CARD"
echo "local ip gateway: $LOCAL_IP_GATEWAY"
echo "netplan config file path: $NETPLAN_CONFIG_FILE_PATH"
echo "wifi name: $WIFI_NAME"

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

#if [ $WIFI_NAME != "" ]; then
if  [ -z "$WIFI_NAME" ]; then

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

else

tee $NETPLAN_CONFIG_FILE_PATH <<EOF
# This is the network config written by 'subiquity'
network:
  version: 2
  wifis:
    $NETWORK_INTERFACE_CARD:
      access-points:
        $WIFI_NAME:
          password: $WIFI_PWD
      #dhcp4: true
      dhcp4: no
      dhcp6: no
      addresses: [$LOCAL_IP/24]
      gateway4: $LOCAL_IP_GATEWAY
      nameservers:
        addresses: [114.114.114.114, 8.8.8.8]
EOF

fi

netplan apply



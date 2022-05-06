
#!/bin/sh

#--

export NODE_NAME=node-0
export LOCAL_IP=192.168.1.100

#--
hostnamectl set-hostname ${NODE_NAME}
sed -i 's/127.0.1.1 c/127.0.1.1 '${NODE_NAME}''



#--

# tee /etc/netplan/00-installer-config.yaml  <<-'EOF'
# network:
#   ethernets:
#     eth0:
#       dhcp4: no
#       dhcp6: no
#       addresses: ['${LOCAL_IP}'/24]
#       gateway4: 192.168.1.1
#       nameservers:
#               addresses: [114.114.114.114, 8.8.8.8]
#   version: 2
# EOF
# netplan apply



#--
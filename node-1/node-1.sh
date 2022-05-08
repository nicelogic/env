
#!/bin/sh


hostnamectl set-hostname "node-1"

# tee /etc/netplan/01-network-manager-all.yaml  <<-'EOF'
# network:
#   ethernets:
#     wlp2s0:
#       dhcp4: no
#       dhcp6: no
#       addresses: [192.168.1.101/24]
#       gateway4: 192.168.1.1
#       nameservers:
#               addresses: [114.114.114.114, 8.8.8.8]
#   version: 2
# EOF
# netplan apply

apt install keepalived -y
apt install haproxy -y

# export NODE_IP=192.168.1.101
# scp ./high-availability/keepalived.conf root@192.168.1.101:/etc/keepalived/keepalived.conf
# scp ./high-availability/check_apiserver.sh root@192.168.1.101:/etc/keepalived/check_apiserver.sh
# scp -r ./high-availability/haproxy.cfg root@192.168.1.101:/etc/haproxy/haproxy.cfg

systemctl enable haproxy --now
systemctl enable keepalived --now
systemctl restart haproxy
systemctl restart keepalived

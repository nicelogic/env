
#!/bin/sh

modprobe br_netfilter
echo "1" > /proc/sys/net/ipv4/ip_forward
sed -i -r -e "s|#net.ipv4.ip_forward.*|net.ipv4.ip_forward=1|g" /etc/sysctl.conf
sysctl -p

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

systemctl stop firewalld
systemctl disable firewalld
sed -i 's/enforcing/disabled/' /etc/selinux/config
setenforce 0


sed -ri 's/.*swap.*/#&/' /etc/fstab
swapoff -a

#docker
# mkdir -p /etc/docker
# tee /etc/docker/daemon.json <<-'EOF'
# {
#   "exec-opts": ["native.cgroupdriver=systemd"],	
#   "registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]
# }
# EOF
# systemctl enable docker 
# systemctl daemon-reload 
# systemctl restart docker 

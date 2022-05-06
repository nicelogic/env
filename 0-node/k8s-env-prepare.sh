
#!/bin/sh

#ssh -T root@192.168.1.101 < k8s-env-prepare.sh

timedatectl set-timezone Asia/Shanghai
apt install ntpdate -y
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
apt install docker.io -y
#docker
systemctl enable docker && systemctl start docker
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "exec-opts": ["native.cgroupdriver=systemd"],	
  "registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]
}
EOF
systemctl daemon-reload 
systemctl restart docker 

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
echo "deb  https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
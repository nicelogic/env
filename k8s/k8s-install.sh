
#!/bin/sh

apt install -y docker.io 
apt install -y apt-transport-https ca-certificates curl
#apt-cache madison kubectl | grep 1.24
apt install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
apt-mark hold kubelet kubeadm kubectl
apt install -y keepalived 
apt install -y haproxy 

echo "k8s install success"
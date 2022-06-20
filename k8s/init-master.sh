
#!/bin/sh

export LOCAL_IP=$1

kubeadm init --image-repository registry.aliyuncs.com/google_containers --apiserver-advertise-address=0.0.0.0  --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint="192.168.1.200:8443" --upload-certs
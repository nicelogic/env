
#!/bin/sh

kubeadm init --image-repository registry.aliyuncs.com/google_containers --apiserver-advertise-address=0.0.0.0  --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint="192.168.1.100"
kubeadm init --image-repository registry.aliyuncs.com/google_containers --apiserver-advertise-address=0.0.0.0  --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint="192.168.1.200:8443" --upload-certs


# kubeadm init --control-plane-endpoint vip.mycluster.local:8443 [additional arguments ...]


# kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

kubeadm join 192.168.1.200:8443 --token jti571.rcfon5vsjpkvn706 --discovery-token-ca-cert-hash sha256:3257d54bc05eed3f5ccba23ac41292596fdadce44069c0bc58e7ff7d67d7e23a --control-plane --certificate-key c7e24664591fe66a293451e0413ad6be9fdb308ca1b507254c40351bcc181be8 --apiserver-advertise-address 192.168.1.101


#!/bin/sh

# kubeadm init phase upload-certs --upload-certs
# 3196d1fe303ef695148738d560355ba7e2dc8b7c5c41711b8d2d387d2ecf321c
# kubeadm token create --print-join-command




 kubeadm join 192.168.1.200:8443 --token mf771d.gm7lvkob322e5vln \
	--discovery-token-ca-cert-hash sha256:f8ca98ae4183cf5a80e0eba34046cce86cf68d10ff83808f2030e1678de7b5fa \
	--control-plane --certificate-key 0ba566ccc534981c9ec53af44069e1d56ee076818b52d7984c6f125674c8c7d8 --apiserver-advertise-address 192.168.1.101

 kubeadm join 192.168.1.200:8443 --token jti571.rcfon5vsjpkvn706 \
	--discovery-token-ca-cert-hash sha256:3257d54bc05eed3f5ccba23ac41292596fdadce44069c0bc58e7ff7d67d7e23a \
	--control-plane --certificate-key c7e24664591fe66a293451e0413ad6be9fdb308ca1b507254c40351bcc181be8

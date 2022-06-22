
#!/bin/sh

kubeadm init phase upload-certs --upload-certs
kubeadm token create --print-join-command


kubeadm join 192.168.1.200:8443 --token aw2szg.95qy0icytkj0g9po --discovery-token-ca-cert-hash sha256:0a03592e0b3dc3ba3c6244ffc029acaedfee8ed4208064497be5ad366bc745ce --control-plane  --certificate-key ed2d97eb98f2855c246ec76ee35f8eaf247e3b2f8250698a8a6c71c0985f51af




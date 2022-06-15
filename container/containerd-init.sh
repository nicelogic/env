
#!/bin/sh

apt install -y containerd

cp -f ./config.toml /etc/containerd/config.toml
systemctl daemon-reload && systemctl restart containerd  

#systemctl daemon-reload && systemctl restart containerd  && systemctl restart kubelet


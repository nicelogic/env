
#!/bin/sh

apt install -y containerd

cp -f ./crictl.yaml /etc/crictl.yaml

mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
cp -f ./config.toml /etc/containerd/config.toml
systemctl daemon-reload && systemctl restart containerd  

#systemctl daemon-reload && systemctl restart containerd  && systemctl restart kubelet


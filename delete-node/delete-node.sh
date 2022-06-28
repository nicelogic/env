
#!/bin/sh

export NODE_NAME=$1

kubectl drain $NODE_NAME --delete-emptydir-data --force --ignore-daemonsets
kubeadm reset
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
ipvsadm -C
kubectl delete node $NODE_NAME


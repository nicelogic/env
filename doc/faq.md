
## faq


## etcd不断重启导致的apiserver不断重启

crictl ps -a 查看etcd,并通过crictl logs etcd-container-id, 发现选举leader出问题
ps aux | grep etcd, 发现

root        4185  5.9  0.2 11215288 39764 ?      Ssl  00:55   0:04 etcd --advertise-client-urls=https://192.168.1.101:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --initial-advertise-peer-urls=https://192.168.1.101:2380 --initial-cluster=node-1=https://192.168.1.101:2380,node-0=https://192.168.1.100:2380 --initial-cluster-state=existing --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.1.101:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.1.101:2380 --name=node-1 --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt


initial-cluster有问题， node-0还存在
export ETCD_INITIAL_CLUSTER="node-1=https://192.168.1.101:2380"
export ETCD_INITIAL_CLUSTER_STATE="new"

/var/lib/kubelet
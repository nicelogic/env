# env

[toc]

## 需求
  * 构建和维护高可用k8s集群
	* 调试dns
	* prometheus //后续支持
  * 支持uninit.sh剥离 node
  * 只需要内网即可

// dashboard给业务吧
//traefik属于带宽流量部分，dashboard需要,后续traefik ok, dashboard ingress需要补上
//k8s架构 + taefik流量 + 数据库 + 微服务
//reloader，和业务层面比较关联
//efk 和业务比较关联
//三大基础部分 + 业务部分
## 如何使用

* sudo passwd root
* git clone https://github.com/nicelogic/env.git
* 配置config.yml
* ./ip-and-ssh.sh
* ./init.sh
 * first master node 
   * if first node,执行k8s init 
   * if first node, init pod network
 * other master node
   * if other master node, ssh to master node, get join master node cmd then k8s join
   * update other master node's haproxy
 * worker node
   * if worker node, ssh to master node, get join worker node cmd then k8s join


## 设计决策
### 网卡名称

* 网卡使用原生网卡名
* 改网卡名称涉及重启，能不重启就不重启
* 有线网卡改成eth0还好，无线物理网卡直接改。ubuntu server重启之后会重制操作，而且启动慢
* 不改网卡，ha/keepalived可能会需要用到网卡名，直接走配置即可。需要多一步配置就是了
  最终选择配置网卡名称方案

### 为何不需要init/join master之后才配置keepalived/ha

因为配置的同时有服务器挂了，就可能负载到本机器，此时本机虽然没有join master
但是ha因为check失败，也会转发到其他可用的master node上。所以没问题



## etcd不断重启导致的apiserver不断重启

crictl ps -a 查看etcd,并通过crictl logs etcd-container-id, 发现选举leader出问题
ps aux | grep etcd, 发现

root        4185  5.9  0.2 11215288 39764 ?      Ssl  00:55   0:04 etcd --advertise-client-urls=https://192.168.1.101:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --initial-advertise-peer-urls=https://192.168.1.101:2380 --initial-cluster=node-1=https://192.168.1.101:2380,node-0=https://192.168.1.100:2380 --initial-cluster-state=existing --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.1.101:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.1.101:2380 --name=node-1 --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt


initial-cluster有问题， node-0还存在
export ETCD_INITIAL_CLUSTER="node-1=https://192.168.1.101:2380"
export ETCD_INITIAL_CLUSTER_STATE="new"

/var/lib/kubelet

## 笔记本关闭屏幕

setterm --blank force


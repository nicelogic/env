# env

[toc]

## 需求
  * 构建高可用k8s架构
  * 其他k8s集群紧耦合层面事物
	* 调试dns
	* dashboard
	* prometheus //后续支持
  * 支持uninit.sh剥离 node
  * 只需要内网即可

//traefik不是，属于带宽流量部分
//k8s架构 + taefik流量 + 数据库 + 微服务
//reloader，和业务层面比较关联
//efk 和业务比较关联
//三大基础部分 + 业务部分
## 如何使用

### 手动操作部分(所有node通用)

* sudo passwd root
* git clone https://github.com/nicelogic/env.git
* 配置config.yml
* ./ip-and-ssh.sh

### 自动部分

#### first master node

* init.sh 
	* if first node,执行k8s init
	* if first node, init pod network

#### other master node

* init.sh
	* if other master node, ssh to master node, get join master node cmd then k8s join
	* update other master node's haproxy

#### worker node

* init.sh
	* if worker node, ssh to master node, get join worker node cmd then k8s join

* 配置config.yml
* init.sh #基础环境配置(如果为Master则包括高可用部分)
* init-or-join.sh #加入k8s

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
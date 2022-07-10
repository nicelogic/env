# env

[toc]

## 需求

* 构建,维护,监控 高可用k8s集群
* 构建,维护,监控 高可用出入口流量
* 构建,维护,监控 基础持久化卷供应
//k8s + taefik + openebs 
//...

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

### traefik集群层面而不是app层面

* 每个app一个traefik, 则高可用得做多套，端口得各定不同，很麻烦
* 整个集群的出入口点，多个app共享，和k8s能力各个app共享一样。简单易于管理


### traefik只需要keepalived不需要ha

traefik本身就是负载均衡，所有带宽过一个服务器，没必要增加ha,画蛇添足
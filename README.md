# env

[toc]

## 需求
  * 构建高可用k8s架构
  * 其他k8s集群层面事物，都归本项目负责
	* dashboard
	* reloader
	* traefik
	* efk //后续支持
	* prometheus //后续支持
  * 支持uninit.sh剥离 node

## 如何使用

### 手动操作部分(所有node通用)

* sudo passwd root
* git clone https://github.com/nicelogic/env.git

### 自动部分

#### first master node

* 配置config.yml
* init.sh 
	* if first node,执行k8s init
	* if first node, init pod network

#### other master node

* 配置config.yml
* init.sh
	* if other master node, ssh to master node, get join master node cmd then k8s join
	* update other master node's haproxy

#### worker node

* 配置config.yml
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


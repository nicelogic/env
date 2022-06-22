# env

## 总体思想

* 目标：拿到机器，安装ubuntu server, 配置config.yml, init即可完成全部操作
* 职责:
  * 构建高可用k8s架构
	* init k8s master node
	* join k8s master/worker node
  * 其他k8s集群层面事物，都归本项目负责
	* dashboard
	* reloader
	* traefik
	* efk //后续支持
	* prometheus //后续支持
  * 支持uninit.sh剥离 node
## 定位

* 安装ubuntu server 20.04+(更新到最新)
* 构建k8s集群环境 
* k8s的基础设施
	* k8s dashboard
	* traefik
	* reloader 
	* efk
* 维护ubuntu server + k8s

## 手动操作部分

* install ubuntu server & sshd
* 增加root pwd
  sudo passwd root
* git clone env
  git clone https://github.com/nicelogic/env.git
* cd env & config config.yml
* ./init.sh

## 裸机部分

* 网卡使用原生网卡名
  * 改网卡名称涉及重启，能不重启就不重启
  * 有线网卡改成eth0还好，无线物理网卡直接改。ubuntu server重启之后会重制操作，而且启动慢
  * 不改网卡，ha/keepalived可能会需要用到网卡名，直接走配置即可。需要多一步配置就是了
  最终选择配置网卡名称方案

## 环境初始监听端口

是HA先DEPLOY还是先JOIN CONTROL PANEL
重点是已有的CONTROL PANEL上的HA不能在MASTER NODE JOIN前更新HA
新NODE可以先配置HA/KEEPALIVED, 后JOIN

最好：
1. 新NODE先初始化环境
2. JOIN MASTER NODE
3. update new node's ha + keepalived
4. update old node ha + keepalived


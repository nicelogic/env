# env

## 总体思想

以k8s为核心的自构建+维护脚本集合
不使用第三方的原因在于： 这部分需要极其稳定，需要每一个细节做到可控
当前也没有一个非常好用的开源仓库
要能够做到极其稳定。只要机器安装了ubuntu server,剩余一个命令就可以完成
构建k8s/加入k8s

## 定位

* 安装ubuntu server 20.04+(更新到最新)
* 构建k8s集群环境 
* k8s的基础设施
	* k8s dashboard
	* traefik
	* reloader 
	* efk
* 维护ubuntu server + k8s

## 规划

* 3+低功耗，低性能服务器做control-panel
* 2+worker node

## 手动操作部分

* install ubuntu server & sshd
* 增加root pwd
  sudo passwd root
* git clone env
  git clone https://github.com/nicelogic/env.git
* 修改init.sh文件更改配置
* ./env/init.sh
	* 修改ip为第一优先级，因为涉及需要reboot
* 后续高可用节点加入，需要有脚本能够自动更新所有其他高可用节点的脚本

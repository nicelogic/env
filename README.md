# env

## 定位

* 安装ubuntu server 20.04+(更新到最新)
* 构建k8s集群环境 
* k8s的基础设施
	* k8s dashboard
	* traefik
	* reloader 

## 规划

* 3+低功耗，低性能服务器做control-panel
* 2+worker node

## cmd

scp ./0-node/authorized_keys root@192.168.1.46:/root/.ssh/authorized_keys 

## 手动操作部分

* install ubuntu server & sshd
* 增加root pwd
  sudo passwd root
* git clone env
  git clone https://github.com/nicelogic/env.git
* 修改init.sh文件更改配置
* ./env/init.sh


## 自动部分

* 



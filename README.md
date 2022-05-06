# env

## 定位

* 安装ubuntu server 20.04+(更新到最新)
* 构建k8s集群环境 
* k8s的基础设施
	* k8s dashboard
	* traefik
	* reloader 


## cmd

scp ./0-node/authorized_keys root@192.168.1.46:/root/.ssh/authorized_keys 
















## 手动操作部分

* install ubuntu server & sshd
* sudo passwd root
* ./env/init.sh
	* change sshd allow root login
	* git clone env
	* host name
	* ip 
	* 更改源(aliyun + k8s aliyun) * update + upgrade


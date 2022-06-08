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
* 关于Haproxy, 判断更新之后，连带更新其他Node


## 环境初始监听端口

root@node-0:~/gitee/env# netstat -tlunp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      817/systemd-resolve 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      273500/sshd: /usr/s 
tcp        0      0 0.0.0.0:8443            0.0.0.0:*               LISTEN      275198/haproxy      
tcp        0      0 127.0.0.1:45825         0.0.0.0:*               LISTEN      107708/containerd   
tcp6       0      0 :::22                   :::*                    LISTEN      273500/sshd: /usr/s 
udp        0      0 127.0.0.53:53           0.0.0.0:*                           817/systemd-resolve 
udp6       0      0 fe80::8ad7:f6ff:fe3:546 :::*                                815/systemd-network 
udp6       0      0 :::55096                :::*                                780/systemd-timesyn 

## error-fix

### 1

Unfortunately, an error has occurred:
	timed out waiting for the condition

This error is likely caused by:
	- The kubelet is not running
	- The kubelet is unhealthy due to a misconfiguration of the node in some way (required cgroups disabled)

If you are on a systemd-powered system, you can try to troubleshoot the error with the following commands:
	- 'systemctl status kubelet'
	- 'journalctl -xeu kubelet'

Additionally, a control plane component may have crashed or exited when started by the container runtime.
To troubleshoot, list all containers using your preferred container runtimes CLI.
Here is one example how you may list all running Kubernetes containers by using crictl:
	- 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause'
	Once you have found the failing container, you can inspect its logs with:
	- 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock logs CONTAINERID'
error execution phase wait-control-plane: couldn't initialize a Kubernetes cluster
To see the stack trace of this error execute with --v=5 or higher

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


## record

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join 192.168.1.100:6443 --token l64bp8.ugj7dr69asc1275v \
	--discovery-token-ca-cert-hash sha256:4bf08c35a4a7e836b10068b5a70ad7ebfa8ef0fd9142aecbf41b2789630f7c35 \
	--control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.100:6443 --token l64bp8.ugj7dr69asc1275v \
	--discovery-token-ca-cert-hash sha256:4bf08c35a4a7e836b10068b5a70ad7ebfa8ef0fd9142aecbf41b2789630f7c35 

#apt-cache madison kubectl | grep 1.24


## backup

root@node-0:~# kubeadm init --image-repository registry.aliyuncs.com/google_containers --apiserver-advertise-address=0.0.0.0  --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint="192.168.1.200:8443" --upload-certs

[init] Using Kubernetes version: v1.24.1
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local node-0] and IPs [10.96.0.1 192.168.1.100 192.168.1.200]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [localhost node-0] and IPs [192.168.1.100 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [localhost node-0] and IPs [192.168.1.100 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
W0614 10:12:49.212206   14056 endpoint.go:57] [endpoint] WARNING: port specified in controlPlaneEndpoint overrides bindPort in the controlplane address
[kubeconfig] Writing "admin.conf" kubeconfig file
W0614 10:12:49.283948   14056 endpoint.go:57] [endpoint] WARNING: port specified in controlPlaneEndpoint overrides bindPort in the controlplane address
[kubeconfig] Writing "kubelet.conf" kubeconfig file
W0614 10:12:49.408954   14056 endpoint.go:57] [endpoint] WARNING: port specified in controlPlaneEndpoint overrides bindPort in the controlplane address
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
W0614 10:12:49.574076   14056 endpoint.go:57] [endpoint] WARNING: port specified in controlPlaneEndpoint overrides bindPort in the controlplane address
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 7.022317 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
[upload-certs] Using certificate key:
979f7c491a201ee42b953b1a6437a731f8b5f400442796a1e64dfaa180aa2d78
[mark-control-plane] Marking the node node-0 as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node node-0 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: lavfgt.0avx8866oelz8fdw
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
W0614 10:12:58.986043   14056 endpoint.go:57] [endpoint] WARNING: port specified in controlPlaneEndpoint overrides bindPort in the controlplane address
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 192.168.1.200:8443 --token lavfgt.0avx8866oelz8fdw \
	--discovery-token-ca-cert-hash sha256:0a03592e0b3dc3ba3c6244ffc029acaedfee8ed4208064497be5ad366bc745ce \
	--control-plane --certificate-key 979f7c491a201ee42b953b1a6437a731f8b5f400442796a1e64dfaa180aa2d78

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.1.200:8443 --token lavfgt.0avx8866oelz8fdw \
	--discovery-token-ca-cert-hash sha256:0a03592e0b3dc3ba3c6244ffc029acaedfee8ed4208064497be5ad366bc745ce 


root@node-0:~# ps aux |grep kube
root       14597  2.1  0.1 753664 46688 ?        Ssl  10:12   0:01 kube-scheduler --authentication-kubeconfig=/etc/kubernetes/scheduler.conf --authorization-kubeconfig=/etc/kubernetes/scheduler.conf --bind-address=127.0.0.1 --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=true
root       14598  4.2  0.1 11216312 46396 ?      Ssl  10:12   0:02 etcd --advertise-client-urls=https://192.168.1.100:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --experimental-initial-corrupt-check=true --initial-advertise-peer-urls=https://192.168.1.100:2380 --initial-cluster=node-0=https://192.168.1.100:2380 --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.1.100:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.1.100:2380 --name=node-0 --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
root       14611  4.7  0.3 820716 96828 ?        Ssl  10:12   0:03 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/etc/kubernetes/pki/ca.crt --cluster-cidr=10.244.0.0/16 --cluster-name=kubernetes --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt --cluster-signing-key-file=/etc/kubernetes/pki/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=true --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --root-ca-file=/etc/kubernetes/pki/ca.crt --service-account-private-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root       14618 14.2  1.3 1106116 339652 ?      Ssl  10:12   0:09 kube-apiserver --advertise-address=192.168.1.100 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root       14760  2.8  0.3 2520444 96320 ?       Ssl  10:12   0:01 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.7
root       14918  0.3  0.1 748136 33832 ?        Ssl  10:13   0:00 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=node-0
root       15067  0.0  0.0   8160  2472 pts/0    S+   10:13   0:00 grep --color=auto kube
root@node-0:~# 

root@node-0:~# netstat -tlunp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:10248         0.0.0.0:*               LISTEN      14760/kubelet       
tcp        0      0 127.0.0.1:10249         0.0.0.0:*               LISTEN      14918/kube-proxy    
tcp        0      0 127.0.0.1:43401         0.0.0.0:*               LISTEN      2715/containerd     
tcp        0      0 192.168.1.100:2379      0.0.0.0:*               LISTEN      14598/etcd          
tcp        0      0 127.0.0.1:2379          0.0.0.0:*               LISTEN      14598/etcd          
tcp        0      0 192.168.1.100:2380      0.0.0.0:*               LISTEN      14598/etcd          
tcp        0      0 127.0.0.1:2381          0.0.0.0:*               LISTEN      14598/etcd          
tcp        0      0 127.0.0.1:10257         0.0.0.0:*               LISTEN      14611/kube-controll 
tcp        0      0 127.0.0.1:10259         0.0.0.0:*               LISTEN      14597/kube-schedule 
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      776/systemd-resolve 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      854/sshd: /usr/sbin 
tcp        0      0 0.0.0.0:8443            0.0.0.0:*               LISTEN      888/haproxy         
tcp6       0      0 :::10250                :::*                    LISTEN      14760/kubelet       
tcp6       0      0 :::6443                 :::*                    LISTEN      14618/kube-apiserve 
tcp6       0      0 :::10256                :::*                    LISTEN      14918/kube-proxy    
tcp6       0      0 :::22                   :::*                    LISTEN      854/sshd: /usr/sbin 
udp        0      0 127.0.0.53:53           0.0.0.0:*                           776/systemd-resolve 
udp6       0      0 fe80::8ad7:f6ff:fe3:546 :::*                                773/systemd-network 
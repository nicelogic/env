
# env

## design

一个高可用k8s集群，最少三台k8s master
主力性能部分必须使用私有云。公有云太贵了。
最好家庭内网部分就可以支持三台master.低功耗的。这样可以忍受挂一台。
一般忍受挂一台服务器就可以了。
vpn专线方式可以做跨域的高可用。但是要让master不作为worker使用。
master不调度任何东西，即使是带宽也可以让traefik只部署在slb服务器上面。
两台机器在腾讯云 + 1台master在私有云。确保腾讯云的两台master是可用的。
worker只部署在私有云。两个私有云之间数据做备份。这样也能实现多集群。
考虑现实情况，暂不实现多集群的高可用（考虑需要耗费的精力及设备）（整个机房断电的情况最终还是得考虑）（核心在于分布式的数据的同步）（cassandra比较好支持跨区域）（这部分很难）

这部分当前测试环境： 2+tecent 2Core4G8M + 1 local master
问题的关键是traefik得部署在公有云，然后负载转发到私有云。公有云和私有云的带宽会被占用。这只能用于测试。
但是生产是可以把2master在公有云1master在local的方案。确保master安全。
然后搞几个worker专门做外网流量的负载。（在指定的worker上面部署traefik即可)(node要有ingress的label)(私网的公网ip搞1个，80/443的转发到ingress服务器，

k8s集群是集群，和公网ip，域名关系不大。traefik暴露的机器去负载带宽就好。
这几台机器可以通过nat通过光猫的公网ip转发数据
通过ddns去监视公网ip,调用api重写cf的规则

# SCRIPT

实现一个自动化的脚本，一台新的机器，只需要执行脚本就可以准备好K8S
甚至于是自动加入K8S集群
组建高可用集群的脚本，自动加入集群的脚本
要做到能够自动化

机器拿到之后，第一步安装ubuntu server 20.04+ lts
然后设置sshd + authorized_keys
.ssh/authorized_keys
剩下的都交给脚本就好了


## cmd

scp ./0-node/authorized_keys root@192.168.1.46:/root/.ssh/authorized_keys 
















# TODO

## TODO

* 调整当前环境，node-0为worker,其他两个笔记本为master
* 将network-traefik纳入env范畴
* 阅读traefik multi instance文档
* 支持node+-label, yml文件配置部署node是否部署traefik
* 网络带宽这块归属于env整个集群层面进行维护
* env的职责包括了整个集群层面的初始化+维护+监控+出入口带宽的初始化/维护/监控, ingress之下则是业务
* env集群层面必要组件设置(dashboard)
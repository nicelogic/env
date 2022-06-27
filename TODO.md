
# TODO

## TODO

* 支持分块日志，新建Log目录，按阶段打印日志
* 1.47 node,执行./init join master, 能自动更新其他node的haproxy配置
  * k8s remove node,能自动更新其他master node的haproxy
  *  测试三个master node,随便关掉哪台，都不影响操作
  且关掉两台不行，且随便启动一台自动恢复。且全部恢复，也照样恢复

* 1.47 node,执行./init join worker node
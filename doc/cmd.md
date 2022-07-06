
## k8s cmd

## main

kubectl  describe  node | grep Ta
kubectl taint nodes --all node-role.kubernetes.io/control-plane- 
kubectl taint node node-1 node-role.kubernetes.io/control-plane:NoSchedule 


--add
kubectl label node k8snode1 ingresscontroller=true
--delete
kubectl label node k8snode1 ingresscontroller-
--update 
kubectl label node k8snode1 ingresscontroller=false --overwrite



## 笔记本关闭屏幕

setterm --blank force

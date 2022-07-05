
## k8s cmd

## main

kubectl taint nodes --all node-role.kubernetes.io/control-plane- 

--add
kubectl label node k8snode1 ingresscontroller=true
--delete
kubectl label node k8snode1 ingresscontroller-
--update 
kubectl label node k8snode1 ingresscontroller=false --overwrite



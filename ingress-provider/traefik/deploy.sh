
     # kubectl --kubeconfig tecent-cloud/base.luojm.com/token/admin.conf apply -k ../skeleton/k8s/traefik/k8s 
        # helm --kubeconfig tecent-cloud/base.luojm.com/token/admin.conf repo add traefik https://helm.traefik.io/traefik
        # helm --kubeconfig tecent-cloud/base.luojm.com/token/admin.conf repo update
        # helm --kubeconfig tecent-cloud/base.luojm.com/token/admin.conf install traefik traefik/traefik --namespace=traefik --values=k8s/traefik/traefik-chart-values.yaml --set nodeSelector."kubernetes\.io/hostname"=k8s-master


#!/bin/sh

# apt install jq -y
# export VIP=192.168.0.40
# export INTERFACE=ens192
# KVVERSION=$(curl -sL https://api.github.com/repos/kube-vip/kube-vip/releases | jq -r ".[0].name")
# # alias kube-vip="docker run --network host --rm ghcr.io/kube-vip/kube-vip:$KVVERSION"
# # kube-vip manifest pod \
# #     --interface $INTERFACE \
# #     --vip $VIP \
# #     --controlplane \
# #     --arp \
# #     --leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml
# docker run --network host --rm ghcr.io/kube-vip/kube-vip:$KVVERSION manifest pod \
#     --interface $INTERFACE \
#     --address $VIP \
#     --controlplane \
#     --services \
#     --arp \
#     --leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml



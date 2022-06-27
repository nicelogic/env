
import os
import yaml

configYml = open(r'../../config.yml')
config = yaml.safe_load(configYml)
isFirstNode = config['is-first-node']
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('is first node: ' + str(isFirstNode))
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))

if not isFirstNode and isMasterHighAvailabilityEnable:
    print('not first node and join master node')
    vip = config['vip']
    os.system('../in-vip-node-ssh-join-master-or-worker.sh ' +
              vip + ' ' + str(isMasterHighAvailabilityEnable))

    haproxyNodes = config['master-high-availability']['haproxy']['nodes']
    localIp = config['local-ip']
    for node in reversed(haproxyNodes):
        nodeIp = node['ip']
        if nodeIp != localIp:
            os.system('scp /etc/haproxy/haproxy.cfg root@' + nodeIp + ':/etc/haproxy/haproxy.cfg')
            os.system('ssh -T root@' + nodeIp + ' systemctl restart haproxy')

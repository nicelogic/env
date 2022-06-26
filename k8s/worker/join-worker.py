
import os
import yaml

configYml = open(r'../../config.yml')
config = yaml.safe_load(configYml)
isFirstNode = config['is-first-node']
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('is first node: ' + str(isFirstNode))
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))

if not isFirstNode and not isMasterHighAvailabilityEnable:
    print('not first node and join worker node')
    vip = config['vip']
    os.system('../in-vip-node-ssh-join-master-or-worker.sh ' + vip + ' ' + str(isMasterHighAvailabilityEnable))



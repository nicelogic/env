
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
    os.system('../get-join-master-or-worker-cmd.sh ' + vip)


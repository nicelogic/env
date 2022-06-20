
import os
import yaml

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isFirstNode = config['is-first-node']
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('is first node: ' + str(isFirstNode) +
      '\nmaster high availability enable: ' + str(isMasterHighAvailabilityEnable))

if isFirstNode:
    os.system('./init-master.sh')
elif isMasterHighAvailabilityEnable:
    #os.system('./join-master.sh')
    print('template not support join master')
else:
    os.system('./join-worker.sh')

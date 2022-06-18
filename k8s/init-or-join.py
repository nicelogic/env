
import os
import yaml

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isFirstNode = config['is-first-node']
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('is first node: ' + str(isFirstNode), + ', master high availability enable: ' + str(isMasterHighAvailabilityEnable))

if isFirstNode:
	os.system('./init-master.sh')
else isMasterHighAvailabilityEnable:
	
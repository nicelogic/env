
import os
import yaml

configYml = open(r'./config.yml')
config = yaml.safe_load(configYml)
isFirstNode = config['is-first-node']
print('is first node: ' + str(isFirstNode)) 
     
if isFirstNode:
    os.system('./init-master.sh')

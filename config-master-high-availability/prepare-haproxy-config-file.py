
import sys
sys.path.append('..')
import yaml
from python_util import util

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
networkInterfaceCard = config['network-interface-card']
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))
if not isMasterHighAvailabilityEnable:
    print('master high availability disabled')
    sys.exit(0)
if networkInterfaceCard is None:
    print('network interface card is not config')
    sys.exit(1)

haproxyCfgFileName = 'config/haproxy.cfg'
haproxyNodeSearchText = r'''	server node.*check'''
haproxyNodeReplaceText = r''
util.replaceText(haproxyNodeSearchText,
                 haproxyNodeReplaceText, haproxyCfgFileName)

haproxyNodes = config['master-high-availability']['haproxy']['nodes']
with open(haproxyCfgFileName, 'r') as haproxCfgFile:
    haproxyCfgData = haproxCfgFile.read()
for node in reversed(haproxyNodes):
    if node not in haproxyCfgData:
        print('haproxy config: ' + node)
        haproxyNodeSearchText = r'''^(	#server node-x xxx.xxx.x.xxx:xxxx check)'''
        haproxyNodeReplaceText = r'\g<1>' + '\n	server ' + node + ' check'
        util.replaceText(haproxyNodeSearchText,
                         haproxyNodeReplaceText, haproxyCfgFileName)

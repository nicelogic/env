
import sys
sys.path.append('..')
import yaml
from python_util import util
import os

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))
if not isMasterHighAvailabilityEnable:
    print('master high availability disabled')
    sys.exit(0)

haproxyCfgFileName = 'config/haproxy.cfg'
haproxyNodeSearchText = r'''	server node.*check'''
haproxyNodeReplaceText = r''
util.replaceText(haproxyNodeSearchText,
                 haproxyNodeReplaceText, haproxyCfgFileName)

haproxyNodes = config['master-high-availability']['haproxy']['nodes']
with open(haproxyCfgFileName, 'r') as haproxCfgFile:
    haproxyCfgData = haproxCfgFile.read()
for node in reversed(haproxyNodes):
    nodeName = node['name']
    nodeIp = node['ip']
    nodePort = str(node['port'])
    haproxyNodeItem = nodeName + ' ' + nodeIp + ':' + nodePort
    if nodeName not in haproxyCfgData:
        print('haproxy config: ' + str(node))
        haproxyNodeSearchText = r'''^(	#server node-x xxx.xxx.x.xxx:xxxx check)'''
        haproxyNodeReplaceText = r'\g<1>' + '\n	server ' + haproxyNodeItem + ' check'
        util.replaceText(haproxyNodeSearchText,
                         haproxyNodeReplaceText, haproxyCfgFileName)

os.system('./haproxy-config.sh')
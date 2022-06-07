
import sys
sys.path.append('..')
from python_util import util
import yaml

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
isMasterHighAvailabilityEnable = config['master-high-availability']['enable']
print('master high availability enable: ' +
      str(isMasterHighAvailabilityEnable))
if not isMasterHighAvailabilityEnable:
    print('master high availability disabled')
    sys.exit(0)

# keepalived
keepAlivedPriority = config['master-high-availability']['keepalived']['priority']
keepAlivedVip = config['master-high-availability']['keepalived']['virtual-ipaddress']
apiServerVip = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-vip']
apiServerDestPort = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-dest-port']
print('keep alived priority: ' + str(keepAlivedPriority))
print('keep alived vip: ' + keepAlivedVip)
print('keep alived api server vip: ' + apiServerVip)
print('keep alived api server dest port: ' + str(apiServerDestPort))

keepAlivedPrioritySearchText = r"^(.*priority).*$"
keepAlivedPriorityReplaceText = r"\1 " + str(keepAlivedPriority)
util.replaceText(keepAlivedPrioritySearchText,
                 keepAlivedPriorityReplaceText, 'keepalived.conf')

keepAlivedVipSearchText = r'''^(.*virtual_ipaddress {.*$)
(^\s*).*(\s*$)'''
keepAlivedVipReplaceText = r'''\1
\g<2>''' + keepAlivedVip + r'''\3'''
util.replaceText(keepAlivedVipSearchText,
                 keepAlivedVipReplaceText, 'keepalived.conf')

apiServerVipSearchText = r'''(^export APISERVER_VIP=).+'''
apiServerVipReplaceText = r'\g<1>' + apiServerVip
util.replaceText(apiServerVipSearchText,
                 apiServerVipReplaceText, 'check_apiserver.sh')

apiServerDestPortSearchText = r'''(^export APISERVER_DEST_PORT=)\d+'''
apiServerDestPortReplaceText = r'\g<1>' + str(apiServerDestPort)
util.replaceText(apiServerDestPortSearchText,
                 apiServerDestPortReplaceText, 'check_apiserver.sh')

apiServerDestPort = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-dest-port']
print('keep alived priority: ' + str(keepAlivedPriority))

# haproxy
haproxyNodeSearchText = r'''	server node.*check'''
haproxyNodeReplaceText = r''
util.replaceText(haproxyNodeSearchText, haproxyNodeReplaceText, 'haproxy.cfg')

haproxyNodes = config['master-high-availability']['haproxy']['nodes']
haproxyCfgFileName = 'haproxy.cfg'
with open(haproxyCfgFileName, 'r') as haproxCfgFile:
    haproxyCfgData = haproxCfgFile.read()
for node in reversed(haproxyNodes):
    if node not in haproxyCfgData:
        print('haproxy config: ' + node)
        haproxyNodeSearchText = r'''^(	#server node-x xxx.xxx.x.xxx:xxxx check)'''
        haproxyNodeReplaceText = r'\g<1>' + '\n	server ' +  node + ' check'
        util.replaceText(haproxyNodeSearchText, haproxyNodeReplaceText, 'haproxy.cfg')



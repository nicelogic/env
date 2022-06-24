
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

# keepalived
keepAlivedCfgFileName = 'config/keepalived.conf'
keepAlivedCheckApiServerFileName = 'config/check_apiserver.sh'
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
                 keepAlivedPriorityReplaceText, keepAlivedCfgFileName)
masterKeepAlivedPriority = 101
if keepAlivedPriority < 101:
    keepAlivedStateSearchText = r"^(.*state).*$"
    keepAlivedStateReplaceText = r"\1 " + "BACKUP"
    util.replaceText(keepAlivedStateSearchText,
                     keepAlivedStateReplaceText, keepAlivedCfgFileName)


keepAlivedVipSearchText = r'''^(.*virtual_ipaddress {.*$)
(^\s*).*(\s*$)'''
keepAlivedVipReplaceText = r'''\1
\g<2>''' + keepAlivedVip + r'''\3'''
util.replaceText(keepAlivedVipSearchText,
                 keepAlivedVipReplaceText, keepAlivedCfgFileName)

apiServerVipSearchText = r'''(^export APISERVER_VIP=).+'''
apiServerVipReplaceText = r'\g<1>' + apiServerVip
util.replaceText(apiServerVipSearchText,
                 apiServerVipReplaceText, keepAlivedCheckApiServerFileName)

apiServerDestPortSearchText = r'''(^export APISERVER_DEST_PORT=)\d+'''
apiServerDestPortReplaceText = r'\g<1>' + str(apiServerDestPort)
util.replaceText(apiServerDestPortSearchText,
                 apiServerDestPortReplaceText, keepAlivedCheckApiServerFileName)

apiServerDestPort = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-dest-port']
print('keep alived priority: ' + str(keepAlivedPriority))
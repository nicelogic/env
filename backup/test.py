
import yaml

configYml = open(r'../config.yml')
config = yaml.safe_load(configYml)
keepAlivedCheckApiServerFileName = 'config/check_apiserver.sh'
keepAlivedPriority = config['master-high-availability']['keepalived']['priority']
keepAlivedVip = config['master-high-availability']['keepalived']['virtual-ipaddress']
apiServerVip = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-vip']
apiServerDestPort = config['master-high-availability']['keepalived']['check-apiserver']['apiserver-dest-port']
print('keep alived priority: ' + str(keepAlivedPriority))
print('keep alived vip: ' + keepAlivedVip)
print('keep alived api server vip: ' + apiServerVip)
print('keep alived api server dest port: ' + str(apiServerDestPort))
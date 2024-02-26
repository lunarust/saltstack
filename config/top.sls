salt:
  'rasppi.greece.local':
     - salt.init
     
zabbix:
  'rasppi.greece.local':
     - zabbix.init

grafana:
  'rasppi.greece.local':
     - grafana.init

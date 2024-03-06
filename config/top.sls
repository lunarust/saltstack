salt:
  'aetes.greece.local':
     - salt.init
     
zabbix:
  'helios.greece.local':
     - zabbix_server.init

postgres:
  'helios.greece.local':
     - postgresql.init

## Services

grafana:
  'helios.greece.local':
     - grafana.init

wazuh:
  'aetes.greece.local':
     - wazuh.init


metabase_production:
  'aetes.greece.local':
     - metabase.init

metabase_staging:
  'aetes.greece.local':
     - metabase.init


dockreg:
  'rasppi.greece.local':
     - dockreg.init

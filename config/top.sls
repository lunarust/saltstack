salt:
  'rasppi.greece.local':
     - salt.init
     
zabbix:
  'rasppi.greece.local':
     - zabbix.init

grafana:
  'rasppi.greece.local':
     - grafana.init

postgres:
  'rasppi.greece.local':
     - postgres.init

metabase_production:
  'rasppi.greece.local':
     - metabase.init

metabase_staging:
  'rasppi.greece.local':
     - metabase.init

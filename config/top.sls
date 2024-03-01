salt:
  'rasppi.greece.local':
     - salt.init
     
zabbix:
  'rasppi.greece.local':
     - zabbix_server.init

grafana:
  'rasppi.greece.local':
     - grafana.init

postgres:
  'rasppi.greece.local':
     - postgres.init

dockreg:
  'rasppi.greece.local':
     - dockreg.init

metabase_production:
  'aetes.greece.local':
     - metabase.init

metabase_staging:
  'aetes.greece.local':
     - metabase.init


base:
  '*':
    - common
    - services
salt:
  '*':
    - common
    - services
     
grafana:
  '*':
    - secret

zabbix:
  '*':
    - secret
    
metabase_production:
  'aetes.greece.local':
     - metabase_production

metabase_staging:
  'aetes.greece.local':
     - metabase_staging

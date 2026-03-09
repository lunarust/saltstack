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

tududi:
  'bors.greece.local':
    - tududi
    - secret

homepage:
  'helios.greece.local':
    - common
pihole:
  'helios.greece.local':
    - common
    - secret
graylog:
  'helios.greece.local':
    - graylog
myspeed:
  'bors.greece.local':
    - secret
navidrome:
  'bors.greece.local':
    - common
    - secret

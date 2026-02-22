salt:
  'bors.greece.local':
     - salt.init

graylog:
  'helios.greece.local':
    - graylog.init

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

jenkins:
  'helios.greece.local':
    - jenkins.init

metabase_production:
  'aetes.greece.local':
     - metabase.init

metabase_staging:
  'aetes.greece.local':
     - metabase.init

i3:   #'(gumbys|aetes).greece.local':
  'aetes*':
    - i3.init
  'gumbys*':
    - i3.init

dockreg:
  'rasppi.greece.local':
     - dockreg.init

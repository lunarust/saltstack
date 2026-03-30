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

jasperserver:
  'bors.greece.local':
    - common

tududi:
  'bors.greece.local':
    - tududi
    - secret

homepage:
  'helios.greece.local':
    - common
    - app_ports

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
booklore:
  'bors.greece.local':
    - common
dockhand:
  'bors.greece.local':
    - common


# My toys app
flashcards:
  'tanit.greece.local':
    - app_ports

enigma:
  'tanit.greece.local':
    - app_ports

vids:
  'tanit.greece.local':
    - app_ports

clickbane:
  'tanit.greece.local':
    - app_ports

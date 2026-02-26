base:
  '*':
    - os.init
    - os.cron
    - zabbix_agent.init
    - nginx.init
    - docker.init
    - salt_minion.init
#    - os.packages

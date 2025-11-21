base:
  '*':
    - os.init
    - os.packages
    - os.cron
    - zabbix_agent.init
    - nginx.init
    - docker.init
    - salt_minion.init

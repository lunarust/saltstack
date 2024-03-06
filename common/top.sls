base:
  '*':
    - os.init
    - os.packages
    - zabbix_agent.init
    - nginx.init
    - docker.init
    - salt_minion.init

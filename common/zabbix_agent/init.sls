{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
zabbix_client_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 10050-10051/tcp
{% else %}
# sudo ufw allow 10050:10051
ufw allow 10050:10051/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '10050:10051/tcp'"
{% endif %}

zabbix-agent:
  pkg.installed:
    - name: zabbix-agent
    - skip_verify: True
    - allow_updates: True
  service:
    - running
    - enable: True
    - restart: True
    - watch:
      - file: zabbix_conf
      - pkg: zabbix-agent

zabbix_agent_configuration:
  file.managed:
    - name: /etc/zabbix/zabbix_agent2.conf
    - source: salt://zabbix_agent/zabbix_agent2.conf
    - template: jinja
    - create: True

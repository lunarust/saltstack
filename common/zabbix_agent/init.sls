{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %} 
# and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
### Zabbix
zabbix_client_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 10050-10051/tcp

zabbix_repo_rh:
  file.managed:
    - name: /etc/yum.repos.d/zabbix.repo
    - source: salt://zabbix_agent/repo/zabbix.repo
    - template: jinja
{% else %}
## Debian
### Zabbix
ufw allow 10050:10051/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '10050:10051/tcp'"

zabbix_repo_db:
  file.managed:
    - name: /etc/apt/sources.list.d/zabbix.list
    - source: salt://zabbix_agent/repo/zabbix.list
    - template: jinja    
{% endif %}

{% if grains['fqdn'] != 'helios.greece.local' %}
zabbix_agent_configuration:
  file.managed:
    - name: /etc/zabbix/zabbix_agent2.conf
    - source: salt://zabbix_agent/conf/zabbix_agent2.conf
    - template: jinja
    - create: True
{% endif %}

zabbix-agent2:
  pkg.installed:
    - name: zabbix-agent2
    - skip_verify: True
    - allow_updates: True
  service:
    - running
    - enable: True
    - restart: True
    - watch:
      - pkg: zabbix-agent2


# Add docker group to zabbix user
usermod -aG docker zabbix:
  cmd.run:
    - unless: "groups zabbix| grep docker"


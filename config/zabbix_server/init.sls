## Firewall command
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %} 
# and grains.osmajorrelease >= 6 %}

### Zabbix
zabbix_server_fw:
  firewalld.present:
    - name: public
    - prune_services: False
    - default: False
    - masquerade: False
    - ports:
      - 8080/tcp

{% else %}

# sudo ufw allow 8080
ufw allow 8080/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '8080/tcp'"
{% endif %}

## Files 
zabbix_server_configuration:
  file.managed:
    - name: /etc/zabbix/zabbix_server.conf
    - source: salt://zabbix_server/conf/zabbix_server.conf
    - template: jinja
    - create: True

zabbix_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/zabbix.conf
    - source: salt://zabbix_server/nginx/zabbix.conf
    - template: jinja
    - create: True

zabbix-server.service:
  service:
    - running
    - enable: True
    - restart: True

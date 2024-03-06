## Firewall command
{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}

### Zabbix
zabbix_server_fw:
  firewalld.present:
    - name: public
    - prune_services: False
    - default: False
    - masquerade: False
    - ports:
      - 3000/tcp

{% else %}

# sudo ufw allow 3000
ufw allow 3000/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '3000/tcp'"
{% endif %}


# Grafana container files & volumes
/opt/grafana:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/grafana/data:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/grafana/provisioning:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

grafana_docker:
  file.managed:
    - name: /opt/grafana/docker-compose.yml
    - source: salt://grafana/files/docker-compose.yml
    - template: jinja
    - create: True

grafana_configuration:
  file.managed:
    - name: /opt/grafana/grafana.ini
    - source: salt://grafana/files/grafana.ini
    - template: jinja
    - create: True

# grafana nginx configuration file with upstream to container
grafana_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/grafana.conf
    - source: salt://grafana/nginx/grafana.conf
    - template: jinja
    - create: True

# Plugin
# check version: https://github.com/grafana/grafana-zabbix/releases
zabbix_grafana_plugin_wget:
  cmd.run:
    - names: 
      - wget -O /opt/grafana/data/plugins/alexanderzobnin-zabbix-app-4.4.5.linux_arm64.zip https://github.com/grafana/grafana-zabbix/releases/download/v4.4.5/alexanderzobnin-zabbix-app-4.4.5.linux_arm64.zip 
    - unless: file.exists /opt/grafana/data/plugins/alexanderzobnin-zabbix-app-4.4.5.linux_arm64.zip

zabbix_grafana_plugin_unzip:
  cmd.run:
    - names:
      - unzip /opt/grafana/data/plugin/alexanderzobnin-zabbix-app-4.4.5.linux_arm64.zip -d /opt/grafana/data/plugin/
    - unless: file.path_exists_glob('/opt/grafana/data/plugin/alexanderzobnin-zabbix-app/*')




# reload nginx
nginx -s reload:
  cmd.run

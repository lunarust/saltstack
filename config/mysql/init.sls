## Firewall command
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
### mysql
mysql_server_fw:
  firewalld.present:
    - name: public
    - prune_services: False
    - default: False
    - masquerade: False
    - ports:
      - 3306/tcp
{% else %}
# sudo ufw allow 8090
ufw allow 3306/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '3306/tcp'"
{% endif %}

# mysql container files & volumes
/opt/mysql:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

# mysql container files & volumes
mysql_docker:
  file.recurse:
    - name: /opt/mysql/
    - source: salt://mysql/docker
    - user: rust
    - group: root
    - create: True
    - include_empty: True

## Firewall command
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
### mariadb
mariadb_server_fw:
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

# mariadb container files & volumes
/opt/mariadb:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

# mariadb container files & volumes
mariadb_docker:
  file.recurse:
    - name: /opt/mariadb/
    - source: salt://mariadb/docker
    - user: rust
    - group: root
    - create: True
    - include_empty: True

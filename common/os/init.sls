# Firewall rules

{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
### Salt
salt_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 4505/tcp
      - 4506/tcp
      - 80/tcp
{% else %}
## Debian based
### Salt
ufw allow 4505:4506/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '4505:4506/tcp'"
{% endif %}

# Banner
motd:
  file.managed:
    - name: /etc/motd
    - source: salt://os/files/motd
    - template: jinja

# Bash
bashrc:
  file.managed:
    - name: /home/rust/.bashrc
    - source: salt://os/files/bashrc
    - template: jinja


# Add docker group to zabbix user
usermod -aG zabbix docker:
  cmd.run:
    - unless: "groups zabbix| grep docker"

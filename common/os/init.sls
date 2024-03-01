# Firewall rules

{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
# Zabbix
zabbix_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 10051/tcp
      - 10050/tcp

# Salt
salt_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 4505/tcp
      - 4506/tcp


{% else %}
# Zabbix
ufw allow 10050:10051/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '10051:10051/tcp'"

# Salt
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
usermod -aG docker zabbix:
  cmd.run:
    - unless: "groups zabbix| grep docker"

### Installation of Nginx ###
nginx:
  pkg.installed:
    - name: nginx
    - skip_verify: True
  service:
    - running
    - enable: True
    - restart: True



# Firewall rules
# Zabbix
ufw allow 10051-10051/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '10051-10051/tcp'"

# Salt
ufw allow 4505-4506/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '4505-4506/tcp'"

# Banner
motd:
  file.managed:
    - name: /etc/motd
    - source: salt://os/files/motd
    - template: jinja

# Add docker group to zabbix user
usermod -aG docker zabbix:
  cmd.run:
    - unless: groups zabbix| grep docker

### Installation of Nginx ###
nginx:
  pkg.installed:
    - name: nginx
    - skip_verify: True
  service:
    - running
    - enable: True
    - restart: True


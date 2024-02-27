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

# usermod -aG docker zabbix
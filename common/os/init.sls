
# Banner
motd:
  file.managed:
    - name: /etc/motd
    - source: salt://os/files/motd
    - template: jinja


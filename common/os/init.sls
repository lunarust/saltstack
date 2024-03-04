# Banner
motd:
  file.managed:
    - name: /etc/motd
    - source: salt://os/files/motd
    - template: jinja

# Bash
#bashrc:
#  file.managed:
#    - name: /home/rust/.bashrc
#    - source: salt://os/files/bashrc
#    - template: jinja


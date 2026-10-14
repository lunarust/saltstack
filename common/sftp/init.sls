
/etc/sysconfig/sshd:
   file.managed:
    - source: salt://sftp/files/sshd
    - user: root
    - group: root
    - create: True

/etc/ssh/sshd_config:
   file.managed:
    - source: salt://sftp/files/sshd_config
    - user: root
    - group: root
    - template: jinja
    - create: True

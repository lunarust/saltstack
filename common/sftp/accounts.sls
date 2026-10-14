### Do NOT Create local users for sftp accounts on the server ###
### Add users in sftp/pillar/local_user.sls
### For the passwords, please use the following command: openssl passwd -1
### In doubt, please refer to documentation: https://docs.saltstack.com/en/3000/ref/states/all/salt.states.user.html

### Client - Merchant & External sftp Users ###
{% set users = salt['pillar.get']('ftpusers') %}
{% for user, args in users.items() %}
{{ user }}:
  group.present:
    - gid: {{ args['uuid'] }}

  user.present:
    - fullname: {{ args.name }}
    - shell: /bin/false
    - home: {{ args.home }}
    - uid: {{ args.uuid }}
    - gid: {{ args.uuid }}
    - password: {{ args.passhash }}
    - createhome: False
    - enforce_password: False

{{ user }}_dir:
  file.directory:
      - name: {{ args.home }}/Incoming
      - user: root
      - group: root
      - dir_mode: 755
      - makedirs: True

{{ user }}_dir_incoming:
  file.directory:
      - name: {{ args.home }}/Incoming
      - user: {{ args.name }}
      - group: {{ args.name }}
      - dir_mode: 770
      - makedirs: True
{% endfor %}





### Misc Commands ###
sshd_restart_commands:
  cmd.run:
    - names:
      - systemctl restart sshd

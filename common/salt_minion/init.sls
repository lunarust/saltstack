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

salt_repo_rh:
  file.managed:
    - name: /etc/yum.repos.d/salt.repo
    - source: salt://salt_minion/repo/salt.repo
    - template: jinja      
{% else %}
## Debian based
### Salt
ufw allow 4505:4506/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '4505:4506/tcp'"

salt_repo_db:
  file.managed:
    - name: /etc/sources.list.d/salt.list
    - source: salt://salt_minion/repo/salt.list
    - template: jinja
{% endif %}

salt_minion_conf:
  file.recurse:
    - name: /etc/salt/minion.d/
    - source: salt://salt_minion/minion.d
    - user: root
    - group: root
    - template: jinja
    - file_mode: '644'
    - create: True

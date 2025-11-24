whoami:
  file.managed:
    - name: /home/rust/whoami
    - source: salt://os/whoami
    - template: jinja

# Firewall rules
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
### Salt
salt_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 22/tcp
{% else %}
## Debian based
### Salt
ufw allow 22/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '22/tcp'"
{% endif %}

# SysLog
syslog_graylog:
  file.managed:
    - name: /etc/rsyslog.d/60-graylog.conf
    - source: salt://os/files/60-graylog.conf
    - template: jinja
    - create: True

# Allow syslog to transit via 5140 port
semanage port -a -t syslogd_port_t -p tcp 5140:
  cmd.run

# Reload services
systemctl restart rsyslog:
  cmd.run

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

{% if grains['fqdn'] in ['helios.greece.local', 'bors.greece.local'] %}

# Bash customization only for pies
/etc/profile.d/custom_prompt.sh:
  file.managed:
    - source: salt://os/files/custom_prompt.sh

/etc/profile.d/custom_histformat.sh:
  file.managed:
    - source: salt://os/files/custom_histformat.sh

{% endif %}

{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma

/etc/yum.repos.d:
  file.recurse:
    - source: salt://os/repo/rpm
    - include_empty: True
    - clean: true
    - file_mode: '644'
    - create: True

{% else %}
## Debian based
#salt_download_public_key:
#  cmd.run:
#    curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring-2023.pgp
#  unless:
#    ls /etc/apt/keyrings/salt-archive-keyring-2023.pgp

/etc/apt/sources.list.d:
  file.recurse:
    - source: salt://os/repo/apt
    - include_empty: True
    - clean: false
    - file_mode: '644'
    - create: True

{% endif %}


saltstack_scripts:
  file.recurse:
    - name: /opt/scripts
    - source: salt://os/scripts
    - user: root
    - group: root
    - file_mode: '755'
    - create: True

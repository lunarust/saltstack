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

epel_repo_rh:
  file.managed:
    - name: /etc/yum.repos.d/epel.repo
    - source: salt://os/repo/epel.repo
    - template: jinja
{% else %}
## Debian based

#epel_repo_db:
#  file.managed:
#    - name: /etc/apt/sources.list.d/epel.list
#    - source: salt://os/repo/epel.list
#    - template: jinja
{% endif %}

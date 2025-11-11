{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
### postgres
postgres_client_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 5432/tcp

postgres_repo_rh:
  file.managed:
    - name: /etc/yum.repos.d/postgres.repo
    - source: salt://postgresql/repo/postgres.repo
    - template: jinja

postgres_repo_gpg_key:
  file.managed:
    - name: /etc/pki/rpm-gpg/PGDG-RPM-GPG-KEY-RHEL
    - source: salt://postgresql/repo/PGDG-RPM-GPG-KEY-RHEL

{% else %}
## Debian
### postgres
ufw allow 5432/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '5432/tcp'"

get_repo_gpg:
  cmd.run:
    - curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

postgres_repo_db:
  file.managed:
    - name: /etc/apt/sources.list.d/postgres.list
    - source: salt://postgresql/repo/postgres.list
    - template: jinja
{% endif %}

# install postgres-server
postgresql16-server:
  pkg.installed:
    - skip_verify: True
    - allow_updates: True

# create data directory
/data/postgresql:
  file.directory:
    - user: postgres
    - group: postgres
    - mode: 700
    - makedirs: True

/data/postgresql/main:
  file.directory:
    - user: postgres
    - group: postgres
    - mode: 700
    - makedirs: True


# Configuration files for Postgres
postgres_conf:
  file.recurse:
    - name: /data/postgresql/main/
    - source: salt://postgresql/conf
    - user: postgres
    - group: postgres
    - file_mode: '644'
    - create: True


postgresql.service:
  service:
    - running
    - enable: True
    - restart: True

# ALTER USER postgres PASSWORD 'newsecret';
#
# sudo -u postgres /usr/pgsql-16/bin/initdb -D /data/postgresql/main
# reload postgres configuration
# sudo -u postgres /usr/pgsql-16/bin/pg_ctl reload -D /data/postgresql/main:
#  cmd.run

# or
# sudo systemctl restart postgresql@13-main.service
# or
# SELECT pg_reload_conf()
#
/usr/lib/systemd/system/postgresql.service:
  file.managed:
    - source: salt://postgresql/service/postgresql.service

# Service enable & start
#
# Plugin to monitor postgres via zabbix
# https://www.zabbix.com/documentation/current/en/manual/appendix/config/zabbix_agent2_plugins/postgresql_plugin
#

install_zabbix_agent_plugin_postgres:
 pkg.installed:
   - pkgs:
      - zabbix-agent2-plugin-postgresql

/etc/zabbix/zabbix_agent2.d/plugins.d/postgresql.conf:
  file.managed:
    - source: salt://postgresql/zabbix_agent_conf/postgresql.conf
    - template: jinja

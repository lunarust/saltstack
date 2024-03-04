{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
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
    - name: /data/postgresql/
    - source: salt://postgres/conf
    - user: postgres
    - group: postgres
    - file_mode: '644'
    - create: True

# reload postgres configuration
sudo -u postgres pg_ctl reload -D /data/postgresql/main:
  cmd.run

# or 
# sudo systemctl restart postgresql@13-main.service
# or 
# SELECT pg_reload_conf()

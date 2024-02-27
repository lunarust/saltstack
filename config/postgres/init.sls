# sudo ufw allow 5432
ufw allow 5432/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '5432/tcp'"

# Configuration files for Postgres@13
saltstack_conf:
  file.recurse:
    - name: /etc/postgresql/13/main/
    - source: salt://postgres/conf
    - user: postgres
    - group: postgres
    - file_mode: '644'
    - create: True

# reload postgres configuration
sudo -u postgres /usr/lib/postgresql/13/bin/pg_ctl reload -D /var/lib/postgresql/13/main:
	cmd.run

# or 
# sudo systemctl restart postgresql@13-main.service

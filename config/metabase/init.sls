# sudo ufw allow {{ salt['pillar.get']('NGINXMBPORT') }}
ufw allow {{ salt['pillar.get']('NGINXMBPORT') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('NGINXMBPORT') }}/tcp'"

# Metabase container files & volumes
/opt/metabase:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

metabase_docker:
  file.managed:
    - name: /opt/metabase/docker-compose.yml
    - source: salt://metabase/docker/docker-compose.yml
    - template: jinja
    - create: True

# metabase nginx configuration file with upstream to container
metabase_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/metabase.conf
    - source: salt://metabase/nginx/metabase_nginx.conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

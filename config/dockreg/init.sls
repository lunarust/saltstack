{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %} 
# and grains.osmajorrelease >= 6 %}
dockreg_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 5010/tcp
{% else %}
# sudo ufw allow 5010
ufw allow 5010/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '5010/tcp'"
{% endif %}

# dockreg container files & volumes
/opt/dockreg:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/dockreg/data:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/dockreg/config:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/dockreg/certs:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

dockreg_docker:
  file.managed:
    - name: /opt/dockreg/docker-compose.yml
    - source: salt://dockreg/docker/docker-compose.yml
    - template: jinja
    - create: True

dockreg_configfile:
  file.managed:
    - name: /opt/dockreg/config/config.yml 
    - source: salt://dockreg/config/config.yml
    - template: jinja
    - create: True

# metabase nginx configuration file with upstream to container
dockreg_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/dockreg.conf
    - source: salt://dockreg/nginx/dockreg.conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

docker network create registry_nw:
  cmd.run:
  - unless: docker network inspect registry_nw


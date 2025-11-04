{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
tududinginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('tududi_nginx_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('tududi_nginx_port') }}
ufw allow {{ salt['pillar.get']('tududi_nginx_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('tududi_nginx_port') }}/tcp'"


{% endif %}

# tududi container files & volumes
/opt/tududi:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/tududi/uploads:
  file.directory:
    - user: {{ salt['pillar.get']('tududi_uid') }}
    - group: {{ salt['pillar.get']('tududi_uid') }}
    - mode: 744
    - makedirs: True

/opt/tududi/db:
  file.directory:
    - user: {{ salt['pillar.get']('tududi_uid') }}
    - group: {{ salt['pillar.get']('tududi_uid') }}
    - mode: 744
    - makedirs: True


tududi_docker:
  file.managed:
    - name: /opt/tududi/docker-compose.yml
    - source: salt://tududi/docker/docker-compose.yml
    - template: jinja
    - create: True

# tududi nginx configuration file with upstream to container
tududi_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/tududi.conf
    - source: salt://tududi/nginx/tududi_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

docker network create tududi_nw:
  cmd.run:
  - unless: docker network inspect tududi_nw

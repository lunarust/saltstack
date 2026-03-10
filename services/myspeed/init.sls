{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
myspeednginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('myspeed_nginx_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('myspeed_nginx_port') }}
ufw allow {{ salt['pillar.get']('myspeed_nginx_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('myspeed_nginx_port') }}/tcp'"


{% endif %}

# myspeed container files & volumes
/opt/myspeed/:
  file.recurse:
    - source: salt://myspeed/docker
    - template: jinja
    - create: True

/opt/myspeed/data:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

# myspeed nginx configuration file with upstream to container
myspeed_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/myspeed.conf
    - source: salt://myspeed/nginx/homepage_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

#docker network create myspeed_nw:
#  cmd.run:
#  - unless: docker network inspect myspeed_nw

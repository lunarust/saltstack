{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
homepagenginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('homepage_nginx_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('homepage_nginx_port') }}
ufw allow {{ salt['pillar.get']('homepage_nginx_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('homepage_nginx_port') }}/tcp'"


{% endif %}

# homepage container files & volumes
/opt/homepage/:
  file.recurse:
    - source: salt://homepage/docker
    - template: jinja
    - create: True

/opt/homepage/config:
  file.recurse:
    - source: salt://homepage/config
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - template: jinja

/opt/homepage/icon:
  file.recurse:
    - source: salt://homepage/icon
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - template: jinja


# homepage nginx configuration file with upstream to container
homepage_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/homepage.conf
    - source: salt://homepage/nginx/homepage_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

#docker network create homepage_nw:
#  cmd.run:
#  - unless: docker network inspect homepage_nw

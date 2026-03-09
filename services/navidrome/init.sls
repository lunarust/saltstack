{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
navidromenginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('navidrome_container_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('navidrome_nginx_port') }}
ufw allow {{ salt['pillar.get']('navidrome_container_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('navidrome_container_port') }}/tcp'"


{% endif %}

# navidrome container files & volumes
/opt/navidrome/:
  file.recurse:
    - source: salt://navidrome/docker
    - template: jinja
    - create: True

/opt/navidrome/data:
  file.directory:
    - user: rust
    - group: root
    - file_mode: '775'
    - create: True

/opt/navidrome/music:
  file.directory:
    - user: rust
    - group: root
    - file_mode: '775'
    - create: True

# navidrome nginx configuration file with upstream to container
navidrome_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/navidrome.conf
    - source: salt://navidrome/nginx/homepage_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

#docker network create navidrome_nw:
#  cmd.run:
#  - unless: docker network inspect navidrome_nw

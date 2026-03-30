{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
dockhandnginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('jasperserver_container_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('dockhand_nginx_port') }}
ufw allow {{ salt['pillar.get']('jasperserver_container_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('jasperserver_container_port') }}/tcp'"

{% endif %}

# dockhand container files & volumes
/opt/jasperserver/:
  file.recurse:
    - source: salt://jasperserver/docker
    - template: jinja
    - create: True

/opt/jasperserver/jasper_webapp:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

/opt/jasperserver/jasper_home:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

/opt/jasperserver/jasper-import:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

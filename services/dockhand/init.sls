{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
dockhandnginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('dockhand_nginx_port') }}/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('dockhand_nginx_port') }}
ufw allow {{ salt['pillar.get']('dockhand_nginx_port') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('dockhand_nginx_port') }}/tcp'"

{% endif %}

# dockhand container files & volumes
/opt/dockhand/:
  file.recurse:
    - source: salt://dockhand/docker
    - template: jinja
    - create: True

/opt/dockhand/data:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

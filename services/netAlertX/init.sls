{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
netalertxnginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 20212/tcp
      - 20211/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('netalertx_nginx_port') }}
ufw allow 20212/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '20212/tcp'"


{% endif %}

# netalertx container files & volumes
/opt/netalertx/:
  file.recurse:
    - source: salt://netAlertX/docker
    - template: jinja
    - create: True

/opt/netalertx/data:
  file.directory:
    - user: rust
    - group: root
    - file_mode: 744
    - makedirs: True

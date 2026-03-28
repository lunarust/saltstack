# vids container files & volumes
/opt/vids:
  file.recurse:
    - source: salt://vids/docker
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - include_empty: True

docker network create vids_nw:
  cmd.run:
  - unless: docker network inspect vids_nw

{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
enigma_ports_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('vids_fe') }}/tcp
      - {{ salt['pillar.get']('vids_be') }}/tcp
{% else %}
# sudo ufw allow {{ salt['pillar.get']('graylog_nginx_port') }}
ufw allow {{ salt['pillar.get']('vids_be') }},{{ salt['pillar.get']('vids_fe') }}/tcp:

  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('enigma_be') }}/tcp'"
{% endif %}

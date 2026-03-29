# clickbane container files & volumes
/opt/clickbane:
  file.recurse:
    - source: salt://clickbane/docker
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - include_empty: True
    - template: jinja

docker network create clickbane_nw:
  cmd.run:
  - unless: docker network inspect clickbane_nw

{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
enigma_ports_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('clickbane_be') }}/tcp
      - {{ salt['pillar.get']('clickbane_fe') }}/tcp
{% else %}
# sudo ufw allow {{ salt['pillar.get']('graylog_nginx_port') }}
ufw allow {{ salt['pillar.get']('clickbane_be') }},{{ salt['pillar.get']('clickbane_fe') }}/tcp:

  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('clickbane_fe') }}/tcp'"
{% endif %}

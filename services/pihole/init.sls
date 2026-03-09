## Firewall command
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
### jenkins
jenkins_server_fw:
  firewalld.present:
    - name: public
    - prune_services: False
    - default: False
    - masquerade: False
    - ports:
      - 53/tcp
      - 53/udp
      - 443/tcp
      - {{ salt['pillar.get']('pihole_80') }}/tcp


{% else %}
# sudo ufw allow 8090
ufw allow 53/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '53/tcp'"
ufw allow 53/udp:
  cmd.run:
    - unless: "ufw status verbose | grep '53/udp'"
ufw allow 443/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '443/tcp'"
ufw allow {{ salt['pillar.get']('pihole_80') }}/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('pihole_80') }}/tcp'"
{% endif %}

# pi-hole container files & volumes
pihole_docker:
  file.recurse:
    - name: /opt/pihole/
    - source: salt://pihole/docker
    - user: rust
    - group: root
    - create: True
    - include_empty: True

# pi-hole container files & volumes
/opt/pihole/etc-pihole/:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

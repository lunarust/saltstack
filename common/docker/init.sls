{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
homepagenginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 2375/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('homepage_nginx_port') }}
ufw allow 2375/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '2375/tcp'"


{% endif %}
# Docker install

# Docker subnet configuration
docker_daemon_conf:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/files/daemon.json
    - template: jinja
    - create: True

docker.packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    - skip_verify: True
    - allow_updates: True

docker_service_override:
  file.managed:
    - name: /usr/lib/systemd/system/docker.service
    - source: salt://docker/files/docker.service
    - create: True

docker:
  service:
    - running
    - enable: True
    - restart: True

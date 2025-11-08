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

docker:
  service:
    - running
    - enable: True
    - restart: True

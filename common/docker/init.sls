# Docker install
{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
docker_repo_rh:
  file.managed:
    - name: /etc/yum.repos.d/docker-ce.repo
    - source: salt://docker/repo/docker.repo
    - template: jinja
{% else %}
## Debian
docker_repo_db:
  file.managed:
    - name: /etc/sources.list.d/docker.list
    - source: salt://docker/repo/docker.list
    - template: jinja
{% endif %}


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
    - watch:
      - pkg: docker-ce
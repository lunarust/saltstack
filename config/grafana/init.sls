# sudo ufw allow 3000
ufw allow 3000/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '3000/tcp'"

/opt/grafana:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/grafana/data:
  file.directory:
    - user: rust
    - group: docker
    - mode: 777
    - makedirs: True

/opt/grafana/provisioning:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

grafana_docker:
  file.managed:
    - name: /opt/grafana/docker-compose.yml
    - source: salt://grafana/files/docker-compose.yml
    - template: jinja
    - create: True

grafana_configuration:
  file.managed:
    - name: /opt/grafana/grafana.ini
    - source: salt://grafana/files/grafana.ini
    - template: jinja
    - create: True

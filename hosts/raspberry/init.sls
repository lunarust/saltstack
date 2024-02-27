# Docker subnet configuration 
rasp_docker_daemon:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://hosts/raspberry/docker/daemon.json
    - template: jinja
    - create: True


# Reload docker configuration
systemctl restart docker:
  cmd.run
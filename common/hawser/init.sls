{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
hawsernginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 2376/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('hawser_nginx_port') }}
ufw allow 2376/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '2376/tcp'"
{% endif %}

# Hawser
/opt/scripts/install_hawser.sh:
   file.managed:
     - source: salt://hawser/files/install.sh
     - mode: 754

hawser_install_commands:
  cmd.run:
    - names:
      - /opt/scripts/install_hawser.sh

/etc/hawser/config:
   file.managed:
     - source: salt://hawser/files/config
     - mode: 744
     - template: jinja

### Hawser services ###
/etc/systemd/system/hawser.service:
   file.managed:
      - source: salt://hawser/service/hawser.service
      - user: root
      - group: root
      - mode: '771'
      - create: True

hawser_service_commands:
  cmd.run:
    - names:
      - systemctl enable hawser.service

# Check if it's up and running
# curl http://localhost:2376/_hawser/health
# sudo chmod 666 /var/run/docker.sock
# curl http://localhost:2376/_hawser/health

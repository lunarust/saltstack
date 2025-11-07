# MongoDB 5.0+ doesn't work on RaspberryPie MongoDB requires ARMv8.2-A or higher
# Used https://github.com/themattman/mongodb-raspberrypi-docker
# wget https://github.com/themattman/mongodb-raspberrypi-docker/releases/download/r7.0.4-mongodb-raspberrypi-docker-unofficial/mongodb.ce.pi4.r7.0.4-mongodb-raspberrypi-docker-unofficial.tar.gz
# $ docker load --input mongodb.ce.pi4.r7.0.4-mongodb-raspberrypi-docker-unofficial.tar.gz
# Loaded image: mongodb-raspberrypi4-unofficial-r7.0.4:latest


# Set up server
# Server memory map areas for a process
# sysctl -w vm.max_map_count=262144
# echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
# echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf:
#  cmd.run:
#    - unless: grep vm.max_map_count=262144 /etc/sysctl.conf


#GRAYLOG_HTTP_BIND_ADDRESS: "0.0.0.0:9000"
#GRAYLOG_HTTP_EXTERNAL_URI: "http://localhost:9000/"


# http://admin:PBUZdEUCkE@192.168.1.207:9000
# http://admin:PBUZdEUCkE@helios.greece.local:9000


{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
graylognginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - {{ salt['pillar.get']('graylog_nginx_port') }}/tcp
      - 5044/tcp
      - 9000/tcp
      - 5140/tcp
      - 5140/udp
      - 5555/tcp
      - 5555/udp
      - 12201/tcp
      - 13301/tcp
      - 13302/tcp
      - 1514/tcp
      - 12201/udp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('graylog_nginx_port') }}
ufw allow {{ salt['pillar.get']('graylog_nginx_port') }},5044,5140,5555,12201,13301,13302,9000,1514,5140,12201/tcp:

  cmd.run:
    - unless: "ufw status verbose | grep '{{ salt['pillar.get']('graylog_nginx_port') }}/tcp'"
{% endif %}

# graylog container files & volumes
/opt/graylog:
  file.directory:
    - user: rust
    - group: docker
    - mode: 744
    - makedirs: True

/opt/graylog/mongodb_data:
  file.directory:
    - user: systemd-coredump
    - group: root
    - mode: 744
    - makedirs: True

/opt/graylog/mongodb_config:
  file.directory:
    - user: systemd-coredump
    - group: root
    - mode: 744
    - makedirs: True

/opt/graylog/graylog-datanode:
  file.directory:
    - user: systemd-coredump
    - group: input
    - mode: 744
    - makedirs: True

/opt/graylog/graylog_data:
  file.directory:
    - user: 1100
    - group: 1100
    - mode: 744
    - makedirs: True


graylog_docker:
  file.managed:
    - name: /opt/graylog/docker-compose.yml
    - source: salt://graylog/docker/docker-compose.yml
    - template: jinja
    - create: True

graylog_env:
  file.managed:
    - name: /opt/graylog/.env
    - source: salt://graylog/docker/.env
    - template: jinja
    - create: True

# graylog nginx configuration file with upstream to container
graylog_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/graylog.conf
    - source: salt://graylog/nginx/graylog_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

docker network create graylog_nw:
  cmd.run:
  - unless: docker network inspect graylog_nw

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
      - 8090/tcp
{% else %}
# sudo ufw allow 8090
ufw allow 8090/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '8090/tcp'"
{% endif %}

# jenkins container files & volumes
/opt/jenkins:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

# jenkins container files & volumes
jenkins_docker:
  file.recurse:
    - name: /opt/jenkins/
    - source: salt://jenkins/docker
    - user: rust
    - group: root
    - create: True
    - include_empty: True

# jenkins container files & volumes
/opt/jenkins/scripts:
  file.recurse:
    - source: salt://jenkins/scripts
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - include_empty: True

### Nginx ###
# jenkins nginx configuration file with upstream to container
jenkins_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/jenkins.conf
    - source: salt://jenkins/nginx/jenkins.conf
    - template: jinja
    - create: True

# reload nginx
#jenkins_nginx_reload:
#  cmd.run:
#    - names:
#      - nginx -s reload:

nginx_selinux_8090:
  cmd.run:
    - names:
      - semanage permissive -a httpd_t
      - semanage port -a -t http_port_t  -p tcp 8090

### Jenkins services ###
/etc/systemd/system/jenkins.service:
   file.managed:
      - source: salt://jenkins/service/jenkins.service
      - user: root
      - group: root
      - mode: '771'
      - create: True

jenkins_service_commands:
  cmd.run:
    - names:
      - systemctl enable jenkins.service

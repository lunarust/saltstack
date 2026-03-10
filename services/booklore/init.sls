## Firewall command
{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
### booklore
booklore_server_fw:
  firewalld.present:
    - name: public
    - prune_services: False
    - default: False
    - masquerade: False
    - ports:
      - 6060/tcp
{% else %}
# sudo ufw allow 8090
ufw allow 3306/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '6060/tcp'"
{% endif %}

# booklore container files & volumes
/opt/booklore:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

/opt/booklore/data:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

/opt/booklore/books:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

/opt/booklore/bookdrop:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

# booklore container files & volumes
booklore_docker:
  file.recurse:
    - name: /opt/booklore/
    - source: salt://booklore/docker
    - user: rust
    - group: root
    - create: True
    - include_empty: True

# booklore nginx configuration file with upstream to container
booklore_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/booklore.conf
    - source: salt://booklore/nginx/homepage_nginx_conf
    - template: jinja
    - create: True

# reload nginx
nginx -s reload:
  cmd.run

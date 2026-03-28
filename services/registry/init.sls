{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
registrynginx_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 5000/tcp

{% else %}
# sudo ufw allow {{ salt['pillar.get']('registry_nginx_port') }}
ufw allow 5000/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '5000/tcp'"
{% endif %}

# registry container files & volumes
/opt/registry/:
  file.recurse:
    - source: salt://registry/docker
    - template: jinja
    - create: True

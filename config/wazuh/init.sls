{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %} 
# and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
### wazuh
wazuh_client_fw:
  firewalld.present:
    - name: public
    - default: False
    - masquerade: False
    - prune_services: False
    - ports:
      - 4443/tcp
{% else %}
## Debian
### wazuh
ufw allow 4443/tcp:
  cmd.run:
    - unless: "ufw status verbose | grep '4443/tcp'"  
{% endif %}

# Wazuh container files & volumes
/opt/wazuh:
  file.directory:
    - user: root
    - group: root
    - mode: 744
    - makedirs: True

wazuh_files:
  file.recurse:
    - name: /opt/wazuh
    - source: salt://wazuh/docker
    - user: root
    - group: root
    - file_mode: '755'
    - create: True
    - template: jinja
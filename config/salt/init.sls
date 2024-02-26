## Firewall command

### Salt
#public:
#  firewalld.present:
#    - name: public
#    - prune_services: False
#    - default: False
#    - masquerade: False
#    - ports:
#      - 4505-4506/tcp

## Files 
### Static 
saltstack_conf:
  file.recurse:
    - name: /etc/salt/master.d/
    - source: salt://salt/config
    - user: root
    - group: root
    - file_mode: '644'
    - create: True

saltstack_scripts:
  file.recurse:
    - name: /opt/scripts
    - source: salt://salt/scripts
    - user: root
    - group: root
    - file_mode: '755'
    - create: True


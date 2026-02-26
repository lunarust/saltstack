helios_scripts:
  file.recurse:
    - name: /opt/scripts
    - source: salt://helios/files/scripts
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True

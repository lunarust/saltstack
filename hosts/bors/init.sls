bors_scripts:
  file.recurse:
    - name: /opt/scripts
    - source: salt://bors/files/scripts
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True

bors_scripts_config:
  file.managed:
    - name: /opt/scripts/config/Default.toml
    - source: salt://bors/files/config/Default.toml
    - user: rust
    - group: root
    - create: True

scripts:
  file.recurse:
    - name: /opt/scripts
    - source: salt://bors/files/scripts
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True

/home/rust/.config/i3/config:
  file.managed:
    - source: salt://i3/i3_config
    - template: jinja
    - create: True

/home/rust/.config/i3status/config:
  file.managed:
    - source: salt://i3/i3status_config
    - template: jinja
    - create: True

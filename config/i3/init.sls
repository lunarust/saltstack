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

uptime | awk ' { gsub(",",""); print $3 }' >| ~/.config/i3/uptime:
  cron.present:
    - identifier: Uptime_i3
    - user: rust
    - minute: '*/10'


yum -q check-update | sed '/^$/d' | wc -l >| ~/.config/i3/pkgupdate:
  cron.present:
    - identifier: Check_Updates
    - user: rust
    - minute: '*/15'


{% if grains['fqdn'] == 'gumbys.greece.local' %}
cd /opt/scripts/ && ./wobblealert >> /var/log/scripts/wobblealert 2>&1:
  cron.present:
    - identifier: Check_Wobbles
    - user: rust
    - minute: '7'
    - hour: '*/2'
{% endif %}    
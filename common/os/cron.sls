
{% if grains['fqdn'] == 'bors.greece.local' %}
cd /opt/scripts/ && ./wobblealert >> /var/log/scripts/wobblealert 2>&1:
  cron.present:
    - identifier: Check_Wobbles
    - user: rust
    - minute: '7'
    - hour: '*'

cd /opt/scripts/ && ./flux2post >> /var/log/scripts/flux2post 2>&1:
  cron.present:
    - identifier: flux2post
    - user: rust
    - minute: '20'
    - hour: '*'

cd /opt/scripts/ && ./hazevents >> /var/log/scripts/hazevents 2>&1:
  cron.present:
    - identifier: hazevents
    - user: rust
    - minute: '15'
    - hour: '*'

{% endif %}

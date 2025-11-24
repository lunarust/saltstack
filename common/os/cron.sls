
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
    - minute: '10'
    - hour: '*'

cd /opt/scripts/ && ./hazevents >> /var/log/scripts/hazevents 2>&1:
  cron.present:
    - identifier: hazevents
    - user: rust
    - minute: '8'
    - hour: '11'
{% elif grains['fqdn'] == 'aetes.greece.local' %}
cd /git/saltstack/hosts/aetes/ && ./rsync_allgit.sh >> /var/log/scripts/rsync_allgit_sh 2>&1:
  cron.present:
    - identifier: rsync_allgit_sh
    - user: rust
    - minute: '7'
    - hour: '*'

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

{% endif %}

{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}

cd /opt/scripts/ && ./update_rh.sh >> /var/log/scripts/checksecurity_rh 2>&1:
  cron.present:
    - identifier: check_sec_patch_rh
    - user: root
    - minute: '21'
    - hour: 20
{% else %}
cd /opt/scripts/ && ./update_db.sh >> /var/log/scripts/checksecurity_db 2>&1:
  cron.present:
    - identifier: check_sec_patch_db
    - user: root
    - minute: '21'
    - hour: 20
{% endif %}


### Installation of Nginx ###
nginx:
  pkg.installed:
    - name: nginx
    - skip_verify: True
  service:
    - running
    - enable: True
    - restart: True


# Add docker group to nginx user
usermod -aG zabbix nginx:
  cmd.run:
    - unless: "groups zabbix| grep nginx"    
    
# Zabbix nginx ping configuration
zabbix_nginx_configuration:
  file.managed:
    - name: /etc/nginx/conf.d/zabbix_ping.conf
    - source: salt://nginx/files/zabbix_ping.conf
    - template: jinja
    - create: True

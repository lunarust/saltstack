# saltstack


# Migration:
Zabbix>
pg_dump -h 192.168.1.217 -U zabbix -F c zabbix > zabbix.tar



CREATE USER zabbix WITH PASSWORD 'za8s0F423dsa#';
GRANT ALL ON DATABASE zabbix TO zabbix;

pg_restore -U zabbix -Ft -d zabbix < zabbix.tar


psql -U zabbix -d zabbix < zabbix

zabbix=#
zabbix=#
zabbix=# GRANT USAGE ON SCHEMA public TO zabbix;
GRANT
zabbix=# GRANT ALL ON ALL TABLES IN SCHEMA public TO zabbix;
GRANT
zabbix=# GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO zabbix;


WIFI
nmcli radio wifi on
nmcli dev wifi list
sudo nmcli dev wifi connect network-ssid password "network-password"



docker system prune --all --force
✔ Network graylog_graylog_nw    Created                                                                                                                                 0.8s
✔ Container graylog-datanode-1  Started                                                                                                                                 2.5s
✔ Container graylog-mongodb-1   Started                                                                                                                                 2.5s
✔ Container graylog-graylog-1   Started    

## Salt

[Setup README](config/salt/README.md)

Documentation:
- [Install](https://www.tutorialspoint.com/saltstack/saltstack_installation.htm)
- [New repository](https://saltproject.io/blog/salt-project-package-repo-migration-and-guidance/)


Configuration and setup:


## Graylog

Install & Configuration:
[Install](config/graylog/README.md).

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

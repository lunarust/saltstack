- Restart service

systemctl restart postgresql

- Reload without restarting for minor changes
/usr/pgsql-16/bin/pg_ctl reload -D /data/postgresql/main


[Zabbix - PostgreSQL plugin](https://www.zabbix.com/documentation/current/en/manual/appendix/config/zabbix_agent2_plugins/postgresql_plugin)

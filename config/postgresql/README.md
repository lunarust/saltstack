# PostgreSQL


- Restart service
```bash
# This will break all connection
systemctl restart postgresql
```

- Reload without restarting for minor changes
```bash
/usr/pgsql-16/bin/pg_ctl reload -D /data/postgresql/main
```



# Monitoring via Zabbix

[Zabbix - PostgreSQL plugin](https://www.zabbix.com/documentation/current/en/manual/appendix/config/zabbix_agent2_plugins/postgresql_plugin)

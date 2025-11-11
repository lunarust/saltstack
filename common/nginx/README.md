# Configuration

One service per file pushed under conf.d, the files are located and pushed with the service or application.

# Common commands

```bash
nginx -s reload
```


# Monitoring
[Zabbix Nginx monitoring](https://www.zabbix.com/integrations/nginx)

! add a macro to the host entry in Zabbix Server with the new value of the port used for nginx:
{$NGINX.STUB_STATUS.PORT}

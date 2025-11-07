# Add conf file
SYSLOGraylog_conf:
  file.managed:
    - name: /etc/rsyslog.d/60-graylog.conf
    - source: salt://syslog/files/60-graylog.conf
    - template: jinja
    - create: True

# Allow syslog to transit via 5140 port
semanage port -a -t syslogd_port_t -p tcp 5140:
  cmd.run

# Reload services
systemctl restart rsyslog:
  cmd.run

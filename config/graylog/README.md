# Install

Completed in containers on RaspberryPie, web service behind nginx.

## Customize docker-compose

Create a .env file and replace the values per instruction.

[env file](https://github.com/Graylog2/docker-compose/blob/main/open-core/.env.example)




## Issue with MongoDB

MongoDB 5.0+ doesn't work on RaspberryPie MongoDB requires ARMv8.2-A or higher
Followed & used custom build from:  https://github.com/themattman/mongodb-raspberrypi-docker
```bash
wget https://github.com/themattman/mongodb-raspberrypi-docker/releases/download/r7.0.4-mongodb-raspberrypi-docker-unofficial/mongodb.ce.pi4.r7.0.4-mongodb-raspberrypi-docker-unofficial.tar.gz

docker load --input mongodb.ce.pi4.r7.0.4-mongodb-raspberrypi-docker-unofficial.tar.gz
```

Simply replace the service image to mongodb-raspberrypi4-unofficial-r7.0.4:latest


## Graylog start

Once graylog starts the first time it will provide you with creadentials to create and dispatch a certificate.


# SYSLOG

## Graylog configuration

Input: SysLOGUDP
![New Input](../../screenshots/GRAYLOG-SYSLOGUDPInputsCreation.png)

Indice: SysLOGIndex

![New Input](../../screenshots/GRAYLOG-SYSLOGUDPIndexCreation.png)

Stream: SYSLOG
![New Input](../../screenshots/GRAYLOG-SYSLOGUDPStreamCreation.png)

Start your input.

Check your stream:
![New Input](../../screenshots/GRAYLOG-SYSLOGUDP_CheckEntries.png)



## Setup the hosts

On hosts add syslog redirection to graylog in /etc/rsyslog.d/60-graylog.conf

```bash
*.*@192.168.1.207:5140;RSYSLOG_SyslogProtocol23Format
```

Allow Selinux to use port 5140
```bash

semanage port -a -t syslogd_port_t -p tcp 5140:
```

Check traffic:

```bash
tcpdump -i any -v "port 5140"
```

# TODO

[] Remaining exceptions
[] Configuration streams & Inputs


Reference:
[Graylog doc](https://go2docs.graylog.org/current/home.htm)
[Graylog repository](https://github.com/Graylog2)
[Graylog docker-compose repo](https://github.com/Graylog2/docker-compose)

Custom MongoDB:
[MongoDB themattman](https://github.com/themattman/mongodb-raspberrypi-docker)

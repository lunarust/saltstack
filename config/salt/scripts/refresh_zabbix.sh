#!/bin/bash

cd /srv/saltstack/
git pull
salt 'rasppi*' state.highstate \ saltenv=salt # -l debug


salt 'rasppi*' state.highstate \ saltenv=zabbix # -l debug

#!/bin/bash

cd /srv/saltstack/
git pull
salt 'rasppi*' state.highstate \ saltenv=base # -l debug


salt 'rasppi*' state.highstate \ saltenv=grafana # -l debug

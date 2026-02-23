#!/bin/bash
#===============================================================================
#         FILE: start.sh
#       AUTHOR: Celine H.
#         TODO:
#===============================================================================
WHOAMI=graylog

cd /opt/${WHOAMI}
docker-compose up -d

sleep 1

docker ps --format "{{.Status}} {{.Names}}" | grep ${WHOAMI}

echo `date` "Operation for ${0##*/} completed, be polite and say bye, bye now ヾ(^_^)"

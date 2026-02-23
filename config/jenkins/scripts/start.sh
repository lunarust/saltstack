#!/bin/bash
#===============================================================================
#         FILE: start.sh
#       AUTHOR: Celine H.
#         TODO:
#===============================================================================
WHOAMI=jenkins

cd /opt/${WHOAMI}
docker-compose up -d

sleep 1

docker ps --format "{{.Status}} {{.Names}}" | grep jenkins

echo `date` "Operation for ${0##*/} ${WHOAMI} completed, be polite and say bye, bye now ヾ(^_^)"

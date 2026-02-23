#!/bin/bash
#===============================================================================
#         FILE: start.sh
#       AUTHOR: Celine H.
#         TODO:
#===============================================================================
WHOAMI=grafana

cd /opt/${WHOAMI}

docker-compose down

docker-compose pull

docker-compose up -d

echo `date` "Operation for ${0##*/} ${WHOAMI} completed, be polite and say bye, bye now ヾ(^_^)"

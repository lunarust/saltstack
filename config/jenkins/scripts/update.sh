#!/bin/bash
#===============================================================================
#         FILE: start.sh
#       AUTHOR: Celine H.
#         TODO:
#===============================================================================
WHOAMI=jenkins

cd /opt/${WHOAMI}
docker-compose down ${WHOAMI}

docker-compose pull ${WHOAMI}

docker-compose up ${WHOAMI} -d

echo `date` "Operation for ${0##*/} ${WHOAMI} completed, be polite and say bye, bye now ヾ(^_^)"

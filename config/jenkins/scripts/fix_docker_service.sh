#!/bin/bash
#===============================================================================
#         FILE: build_salt_jobs.sh
#       AUTHOR: Celine H.
#      COMMENT: Having trouble with container docker service atm
#===============================================================================


CONTAINERNAME=jenkins-sandbox-agent

if [[ "${HOSTNAME}" == 'helios.greece.local' ]]; then
  CONTAINERNAME=rust_java_backend_node
fi

CHECK=`docker exec ${CONTAINERNAME} service docker status`
CHECK="${CHECK%\"}"
CHECK="${CHECK#\"}"
CHECK=${CHECK//$'\r'}
echo ".. Current status for ${CONTAINERNAME}: [${CHECK}]"

if [[ "$CHECK" != "Docker is running." ]]; then
  docker exec ${CONTAINERNAME} rm /var/run/docker.pid
  docker exec ${CONTAINERNAME} service docker start
else
  echo "We should be fine."
fi

echo ".. Good luck human .╮ (. ❛ ᴗ ❛.) ╭"

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

echo ".. Checking if the container is up & running"

CT=`docker ps --format "{{.Names}}" | grep ${CONTAINERNAME} | wc -l`

if [[ ${CT} != 1 ]]; then
  cd /opt/jenkins
  docker-compose up ${CONTAINERNAME} -d
fi

echo ".. Having a quick nap (_ _) ᶻ 𝗓 𐰁 | ᶻ 𝘇 𐰁 "
sleep 1


echo ".. Checking the service"
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

#!/bin/bash
WHOAMI=graylog
function launchdocker {

  echo "==== Starting Docker ===="
  cd /opt/${WHOAMI}
  docker-compose -f /opt/${WHOAMI}/docker-compose.yml up -d
  #docker-compose ps
  sleep 50
  docker-compose -f /opt/${WHOAMI}/docker-compose.yml up -d

  exit 0
}

start() {
  launchdocker
}

stop() {
  cd /opt/${WHOAMI}/
  docker-compose  -f /opt/${WHOAMI}/docker-compose.yml down
}

restart() {
  stop
  sleep 1
  start
}
status() {
  echo $(docker ps| wc -l)
}

case "$1" in
	start)
	start &
		;;
	stop)
	stop
		;;
	restart)
	restart
		;;
	status)
	status
		;;
	*)

	echo $"Usage: $0 {start|stop|status|restart}"
	exit 1
		;;
esac

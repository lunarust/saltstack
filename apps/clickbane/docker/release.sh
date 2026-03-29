#!/bin/bash
#===============================================================================
#         FILE: release.sh
#       AUTHOR: Celine H.
#===============================================================================
cd /opt/clickbane
docker-compose pull
docker-compose down && docker-compose up -d

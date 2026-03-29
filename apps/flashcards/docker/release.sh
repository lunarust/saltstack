#!/bin/bash
#===============================================================================
#         FILE: release.sh
#       AUTHOR: Celine H.
#===============================================================================
cd /opt/flashcards
docker-compose pull
docker-compose down && docker-compose up -d

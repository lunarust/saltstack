#!/bin/bash
#===============================================================================
#         FILE: rsync_saltstack.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================
DATE=$(date +"%Y-%m-%d_%H%M")

containername=$1
action=$2

bors=("registry" "dockhand" "mariadb" "navidrome" "booklore" "myspeed")
helios=("jenkins-sandbox" "netalertx" "pihole" "homepage" "grafana")
tanit=("flashcards_backend" "flashcards_frontend" "clickbane_backend" "clickbane_frontend" "enigma_backend" "enigma_frontend")

if [[ " ${bors[*]} " =~ $containername ]]; then

host=bors.greece.local

fi

if [[ " ${tanit[*]} " =~ $containername ]]; then

host=tanit.greece.local

fi

if [[ " ${helios[*]} " =~ $containername ]]; then

host=helios.greece.local

fi

salt ${host} cmd.run "docker ${action} ${containername}"

echo ".. Anyway, dear hooman, bye now ヾ(^_^)"

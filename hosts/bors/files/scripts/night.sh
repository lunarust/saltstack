#!/bin/bash
#===============================================================================
#         FILE: night.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================
DATE=$(date +"%Y-%m-%d_%H%M")

containername=$1

bors=("registry" "dockhand" "navidrome" "booklore")
helios=("jenkins-sandbox" "netalertx" "homepage")
tanit=("flashcards_backend" "flashcards_frontend" "clickbane_backend" "clickbane_frontend" "enigma_backend" "enigma_frontend" "jenkins-sandbox-agent")



for i in "${bors[@]}"
do
  echo "$i"
  salt 'bors.greece.local' cmd.run "docker stop ${i}"
done

for i in "${helios[@]}"
do
  echo "$i"
  salt 'helios.greece.local' cmd.run "docker stop ${i}"
done

for i in "${tanit[@]}"
do
  echo "$i"
  salt 'tanit.greece.local' cmd.run "docker stop ${i}"
done

echo ".. Anyway, dear hooman, sleep tight ヾ(^_^)"

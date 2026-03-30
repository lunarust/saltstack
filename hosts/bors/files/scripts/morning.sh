#!/bin/bash
#===============================================================================
#         FILE: morning.sh
#       AUTHOR: Celine
# ORGANIZATION: ---
#      VERSION: 0.0.1
#         TODO:
#===============================================================================
DATE=$(date +"%Y-%m-%d_%H%M")

containername=$1

bors=("dockhand" "booklore")
helios=("netalertx" "homepage")
tanit=("flashcards_backend" "flashcards_frontend" "clickbane_backend" "clickbane_frontend" "enigma_backend" "enigma_frontend")



for i in "${bors[@]}"
do
  echo "$i"
  salt 'bors.greece.local' cmd.run "docker start ${i}"
done

for i in "${helios[@]}"
do
  echo "$i"
  salt 'helios.greece.local' cmd.run "docker start ${i}"
done

for i in "${tanit[@]}"
do
  echo "$i"
  salt 'tanit.greece.local' cmd.run "docker start ${i}"
done

echo ".. Anyway, dear hooman, sleep tight ヾ(^_^)"

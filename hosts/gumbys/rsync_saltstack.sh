#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
rsync -avzh ~/git/saltstack/ rust@192.168.1.216:/srv/saltstack/
echo "$DATE rsync completed"
#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

fswebcam -r 1280x720 --no-banner /home/rust/webcam/$DATE.jpg

sudo apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer
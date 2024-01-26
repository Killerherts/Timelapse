#!/bin/bash
ffmpeg -f video4linux2 -i /dev/video0 -frames:v 1 /mnt/toth/Growtimelapse/caps/p_$(date +"%Y%m%d%H%M%S").jpg


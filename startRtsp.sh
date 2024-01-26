#!/bin/bash

DEVICE="/dev/video0"
URL="rtsp://localhost:8554/mystream"

while true; do
    if [ -e "$DEVICE" ]; then
        ffmpeg -f v4l2 -i $DEVICE -c copy -f rtsp $URL
        echo "Stream started"
        break
    else
        echo "Device not found, retrying in 5 seconds..."
        sleep 5
    fi
done


#!/bin/bash

# Directory where you want to save the image
SAVE_DIR="/mnt/toth/Growtimelapse/caps2"

# URL of the image
IMAGE_URL="http://10.88.88.17:8080/photo.jpg"

# Directory for logs
LOG_DIR="/mnt/toth/Growtimelapse/logs"

# Ensure log directory exists
mkdir -p $LOG_DIR

# Log file
LOG_FILE="$LOG_DIR/download_log.txt"

# Maximum log file size in bytes (e.g., 50000 for ~50KB)
MAX_LOG_SIZE=50000

# Filename with date-time stamp
FILENAME="photo_$(date +%Y%m%d_%H%M%S).jpg"

# Full path for the image to be saved
FULL_PATH="$SAVE_DIR/$FILENAME"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> $LOG_FILE
    # Check if log file size exceeded the max size
    if [ $(stat -c%s "$LOG_FILE") -gt $MAX_LOG_SIZE ]; then
        # Keep the last 100 lines
        tail -n 100 $LOG_FILE > $LOG_FILE.tmp
        mv $LOG_FILE.tmp $LOG_FILE
    fi
}

# Log the attempt
log_message "Attempting to download image to $FULL_PATH"

# Download the image, save it, and log the output and errors
if curl_output=$(curl $IMAGE_URL -o $FULL_PATH 2>&1); then
    # Log success and curl output
    log_message "Image successfully saved to $FULL_PATH. Curl output: $curl_output"
else
    # Log failure and curl output
    log_message "Failed to download image from $IMAGE_URL. Curl output: $curl_output"
fi

echo "Process completed. Check log at $LOG_FILE"

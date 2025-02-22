#!/bin/bash

read -p "Enter the Download URL of a movie or directory: " URL

if [[ -z "$URL" ]]; then
    echo "Error: No URL provided."
    exit 1
fi


LOG_FILE="download_movies.log"

echo "🚀 Starting download at $(date)" | tee -a "$LOG_FILE"

wget -c -r -np -nd -A ".mkv,.mp4,.avi" --show-progress --progress=bar:force --timestamping "$URL" 2>&1 | tee -a "$LOG_FILE"

if [[ $? -ne 0 ]]; then
    echo "⚠️ Download encountered an error!" | tee -a "$LOG_FILE"
else
    echo "✅ Download completed at $(date)" | tee -a "$LOG_FILE"
fi







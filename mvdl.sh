#!/bin/bash

# Function to check available disk space
check_disk_space() {
    REQUIRED_SPACE=10000000  # Example: 10MB required
    AVAILABLE_SPACE=$(df "$PWD" | awk 'NR==2 {print $4}')
    
    if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
        echo "Error: Not enough disk space to download movies."
        exit 1
    fi
}

# Ask for the URL
read -p "Enter the Download URL of a movie or directory: " URL

# Validate input
if [[ -z "$URL" ]]; then
    echo "Error: No URL provided."
    exit 1
fi

# Check disk space before downloading
check_disk_space

# Define log file
LOG_FILE="download_movies.log"

# Start logging
echo "🚀 Starting download at $(date)" | tee -a "$LOG_FILE"

# Download files with detailed logging
wget -c -r -np -nd -A ".mkv,.mp4,.avi" --show-progress --progress=bar:force --timestamping "$URL" 2>&1 | tee -a "$LOG_FILE"

# Check if wget command succeeded
if [[ $? -ne 0 ]]; then
    echo "⚠️ Download encountered an error!" | tee -a "$LOG_FILE"
else
    echo "✅ Download completed at $(date)" | tee -a "$LOG_FILE"
fi







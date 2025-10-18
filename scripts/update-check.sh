#!/bin/bash

# Update reminder script for hypridle
# Simple weekly reminder to check for updates (doesn't run the update)

REMINDER_FILE="$HOME/.cache/last_update_reminder"
WEEK_IN_SECONDS=604800  # 7 days

# Create cache directory
mkdir -p "$HOME/.cache"

# Check if a week has passed since last reminder
if [ -f "$REMINDER_FILE" ]; then
    last_reminder=$(stat -c %Y "$REMINDER_FILE")
    current_time=$(date +%s)
    time_diff=$((current_time - last_reminder))
    
    # Exit if less than a week has passed
    [ $time_diff -lt $WEEK_IN_SECONDS ] && exit 0
fi

# Send simple reminder notification
notify-send -u normal "Weekly System Update Reminder" \
    "It's been a week! Remember to update your system.\n\nRun: sudo pacman -Syu" \
    -i system-software-update

# Update timestamp
touch "$REMINDER_FILE"

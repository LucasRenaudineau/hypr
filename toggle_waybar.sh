#!/bin/bash

# Check if waybar is running
if pgrep -x "waybar" > /dev/null
then
    # Waybar is running, so kill it
    pkill waybar
else
    # Waybar is not running, so start it
    waybar &
fi

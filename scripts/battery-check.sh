#!/bin/bash

# Battery check script for hypridle
# This runs every 5 minutes via hypridle timeout

BATTERY_LOW=20
BATTERY_CRITICAL=10

# Get battery info
battery_level=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
battery_status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)

# Exit if no battery found
[ -z "$battery_level" ] && exit 0

# Only notify if discharging
if [ "$battery_status" = "Discharging" ]; then
    if [ "$battery_level" -le "$BATTERY_CRITICAL" ]; then
        notify-send -u critical "Battery Critical" \
            "Battery at ${battery_level}%!\nPlug in charger now!" \
            -i battery-caution
    elif [ "$battery_level" -le "$BATTERY_LOW" ]; then
        notify-send -u normal "Battery Low" \
            "Battery at ${battery_level}%.\nConsider charging soon." \
            -i battery-low
    fi
fi

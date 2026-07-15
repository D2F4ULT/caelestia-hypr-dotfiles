#!/usr/bin/env bash

MONITORS=$(hyprctl monitors -j)

if echo "$MONITORS" | grep -q "Chimei Innolux Corporation 0x15F5"; then
    echo "Laptop setup detected"

    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1.5"

elif echo "$MONITORS" | grep -q "DELL"; then
    echo "Desk setup detected"

    hyprctl keyword monitor "HDMI-A-1,2560x1440@59.95,0x0,1"
    hyprctl keyword monitor "DP-2,3840x2160@60,2560x0,1"

else
    echo "Unknown monitor detected"

    for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
        hyprctl keyword monitor "$monitor,preferred,auto,1"
    done
fi

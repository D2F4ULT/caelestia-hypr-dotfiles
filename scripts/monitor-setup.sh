#!/usr/bin/env bash
# Manual "fix my screens" helper. Live layout is applied from hyprland/monitors.lua
# by EDID description; this script does not rewrite connector names.
set -euo pipefail

MONS="$(hyprctl monitors -j 2>/dev/null || echo '[]')"

apply() {
    hyprctl keyword monitor "$1" >/dev/null 2>&1 || true
}

name_matching() {
    echo "$MONS" | jq -r --arg pat "$1" '.[] | select((.description // "") | test($pat; "i")) | .name' | head -1
}

dell="$(name_matching "P2421DC")"
lg="$(name_matching "LG HDR 4K")"
laptop="$(name_matching "Chimei Innolux")"

if [[ -n "$dell" && -n "$lg" ]]; then
    apply "${dell},2560x1440@59.95,0x0,1"
    apply "${lg},3840x2160@60,2560x0,1,vrr,1"
    if [[ -n "$laptop" ]]; then
        apply "${laptop},disable"
    fi
    echo "desk: ${dell} (Dell 1440p left) + ${lg} (LG 4K right)"
    exit 0
fi

if [[ -n "$laptop" ]]; then
    apply "${laptop},1920x1080@60,0x0,1.5"
    echo "laptop: ${laptop}"
    exit 0
fi

echo "$MONS" | jq -r '.[] | "\(.name)\t\(.description)\t\(.width)x\(.height)@\(.refreshRate)"'
echo "no known desk/laptop panel matched; printed current outputs" >&2
exit 1

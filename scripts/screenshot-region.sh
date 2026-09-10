#!/usr/bin/env bash
# Region screenshot → clipboard. Avoids Caelestia freeze picker (invisible on this setup).
set -euo pipefail

geom="$(slurp -d)" || exit 0
file="$(mktemp --suffix=.png)"
trap 'rm -f "$file"' EXIT

grim -g "$geom" "$file"
wl-copy --type image/png < "$file"
notify-send -a screenshot -i "$file" "Screenshot copied" "Region saved to clipboard"

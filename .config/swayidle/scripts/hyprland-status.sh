#!/usr/bin/env sh

cat > /home/antoine/.cache/swayidle-workspace <<EOF
ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')
ACTIVE_MONITOR=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .id')
EOF

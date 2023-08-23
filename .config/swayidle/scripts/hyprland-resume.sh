#!/usr/bin/env sh

ACTIVE_WORKSPACE=1
ACTIVE_MONITOR=0
if [ -f "$HOME/.cache/swayidle-workspace" ] ; then
    . "$HOME/.cache/swayidle-workspace"
fi

hyprctl dispatch dpms on
hyprctl dispatch focusmonitor $ACTIVE_MONITOR
hyprctl dispatch workspace $ACTIVE_WORKSPACE

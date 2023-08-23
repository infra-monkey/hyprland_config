#!/usr/bin/env sh

ACTIVE_WORKSPACE=1
ACTIVE_MONITOR=0
if [ -f ".cache/swayidle-workspace" ] ; then
    source ".cache/swayidle-workspace"
fi
echo "hyprctl dispatch workspace $ACTIVE_WORKSPACE" >> /tmp/resume
hyprctl dispatch dpms on
sleep 1
hyprctl dispatch focusmonitor $ACTIVE_MONITOR
hyprctl dispatch workspace $ACTIVE_WORKSPACE

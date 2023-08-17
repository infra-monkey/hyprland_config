#!/usr/bin/env sh

ACTIVE_WORKSPACE=1
ACTIVE_MONITOR=0
if [ -f /home/antoine/.cache/swayidle-workspace ] ; then
    . /home/antoine/.cache/swayidle-workspace
fi

hyprctl dispatch focusmonitor ${ACTIVE_MONITOR}
hyprctl dispatch workspace ${ACTIVE_WORKSPACE}

#!/bin/bash
# __  ______   ____ 
# \ \/ /  _ \ / ___|
#  \  /| | | | |  _ 
#  /  \| |_| | |_| |
# /_/\_\____/ \____|
#                   
# ----------------------------------------------------- 
sleep 1

# stop dbus-kded6 service
systemctl stop --user dbus-:1.2-org.kde.kded6@0.service

# kill all possible running xdg-desktop-portals
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-gnome
killall xdg-desktop-portal-kde
killall xdg-desktop-portal-lxqt
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal
sleep 1

# start xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-hyprland
sleep 2

# start xdg-desktop-portal
systemctl --user start xdg-desktop-portal
sleep 1

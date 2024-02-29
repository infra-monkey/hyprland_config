#!/bin/bash
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# ----------------------------------------------------- 

wallpaper_dir="$HOME/Pictures/Wallpapers"

selected=$( find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
do
    echo -en "$rfile\x00icon\x1f$wallpaper_dir/${rfile}\n"
done | wofi --dmenu)
if [ ! "$selected" ]; then
    echo "No wallpaper selected"
    exit
else
    echo "Selected wallpaper: ${selected}"
fi
ln -vsf $wallpaper_dir/$selected $wallpaper_dir/current_wallpaper

# restart hyprpaper
killall hyprpaper
hyprpaper &

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
sleep 1
notify-send "Colors and Wallpaper updated" "with image $newwall"

echo "DONE!"


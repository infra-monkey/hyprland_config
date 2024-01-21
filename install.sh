#!/bin/sh

function createSymlink {
    local target_link=$1
    local source_link=$2
    if [ $L ${target_link} -a "$(readlink -q -n ${target_link})" == "${source_link}" ]; then
        echo "Symbolic link already exist for ${target_link}"
    else
        echo "Removing exiting target"
        rm -rf ${target_link}
        echo "Creating symbolic link ${source_link} -> ${target_link}"
        ln -vsf ${source_link} ${target_link}
    fi
}
SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

case "${1}" in
    "init")
        echo "source dir = ${SOURCE_DIR}"
        createSymlink "$HOME/.config/hypr" "$SOURCE_DIR/.config/hypr"
        createSymlink "$HOME/.config/alacritty" "$SOURCE_DIR/.config/alacritty"
        createSymlink "$HOME/.config/wal/templates" "$SOURCE_DIR/.config/wal/templates"
        createSymlink "$HOME/.config/waybar" "$SOURCE_DIR/.config/waybar"
        createSymlink "$HOME/.config/mako" "$SOURCE_DIR/.config/mako"
        createSymlink "$HOME/.config/swayidle" "$SOURCE_DIR/.config/swayidle"
        createSymlink "$HOME/.config/wofi" "$SOURCE_DIR/.config/wofi"
        createSymlink "$HOME/.config/fish" "$SOURCE_DIR/.config/fish"
        # createSymlink "$HOME/.config/alacritty" "$SOURCE_DIR/.config/alacritty"
        # createSymlink "$HOME/.config/alacritty" "$SOURCE_DIR/.config/alacritty"
        ;;
    *)
        echo "Missing argument"
        exit 1
esac

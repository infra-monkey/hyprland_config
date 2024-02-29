# Hyprland Installation

Install opensuse tumbleweed KDE edition

Install Hyprland package and dependencies
```
sudo zypper install hyprland xdg-desktop-portal-hyprland kitty alacritty fish sddm qt5-wayland qt6-wayland polkit-kde-agent-5 htop gnome-keyring helvum swayidle swaylock wofi git waybar NetworkManager-applet pipewire wireplumber
```

Copy the .config to your home directory

Reboot and log to hyprland

Enable flatpak apps
```
sudo zypper in flatpak
```



# OpenSUSE Tumbleweed Install

## OS Install

System role : Server

Disks : default layout

## Hyprland Install

```
sudo zypper install git make
mkdir src
cd src
git clone https://github.com/infra-monkey/hyprland_config.git
cd hyprland_config
make build-deps
make hyprlang xdph hyprland
```

## Hyprland ecosystem

install nwg-look from https://build.opensuse.org/package/show/home:smolsheep/nwg-look

install Nordic theme (in .themes)
install candy-icons theme (in .icons)
install Bibata-Modern-Classic cursor theme (in .icons)
configure themes.

```
make runtime-deps
make config

```
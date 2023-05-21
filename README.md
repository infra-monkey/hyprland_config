# Hyprland Installation

Install opensuse tumbleweed KDE edition

Install Hyprland package and dependencies
```
sudo zypper install hyprland kitty alacritty fish sddm qt5-wayland qt6-wayland polkit-kde-agent-5 htop gnome-keyring helvum swayidle swaylock wofi git
```

Enabled extra repo for waybar-hyprland and install it.
```
sudo zypper ar -f https://download.opensuse.org/repositories/home:/tea_moe/openSUSE_Tumbleweed/ "tea_moe"
sudo zypper install waybar-hyprland
```

Install xdg-desktop-portal-hyprland
```
git clone https://github.com/hyprwm/xdg-desktop-portal-hyprland.git
cd xdg-desktop-portal-hyprland/
sudo zypper in ninja meson cmake libpipewire pipewire pipewire-devel wayland-utils wayland-devel wayland-protocols-devel libinih-devel gbm-devel libdrm-devel libuuid-devel systemd-devel
mkdir build
ninja -C build install
meson build --prefix=/usr
```

Copy the .config to your home directory

Reboot and log to hyprland

Enable flatpak apps
```
sudo zypper in flatpak
```

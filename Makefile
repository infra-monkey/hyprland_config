HYPRLAND_SOURCE="https://github.com/hyprwm/Hyprland.git"
HYPRLAND_VERSION="v0.36.0"
HYPRLANG_SOURCE="https://github.com/hyprwm/hyprlang.git"
HYPRLANG_VERSION="v0.5.0"
HYPRPAPER_SOURCE="https://github.com/hyprwm/hyprpaper.git"
HYPRPAPER_VERSION="v0.6.0"
XDPH_SOURCE="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
XDPH_VERSION="v1.3.1"
HYPRLAND_DEPS=gcc-c++ git meson cmake "pkgconfig(cairo)" "pkgconfig(egl)" "pkgconfig(gbm)" "pkgconfig(gl)" "pkgconfig(glesv2)" "pkgconfig(libdrm)" "pkgconfig(libinput)" "pkgconfig(libseat)" "pkgconfig(libudev)" "pkgconfig(pango)" "pkgconfig(pangocairo)" "pkgconfig(pixman-1)" "pkgconfig(vulkan)" "pkgconfig(wayland-client)" "pkgconfig(wayland-protocols)" "pkgconfig(wayland-scanner)" "pkgconfig(wayland-server)" "pkgconfig(xcb)" "pkgconfig(xcb-icccm)" "pkgconfig(xcb-renderutil)" "pkgconfig(xkbcommon)" "pkgconfig(xwayland)" "pkgconfig(xcb-errors)" glslang-devel Mesa-libGLESv3-devel tomlplusplus-devel "pkgconfig(libdisplay-info)"
HYPRLANG_DEPS=qt6-widgets-devel
HYPRPAPER_DEPS=file-devel libwebp-devel libjpeg8-devel
XDPH_DEPS=pipewire-devel
RUNTIME_DEPS=hyprpaper xdg-user-dirs alacritty fish greetd gtkgreet qt6-wayland polkit-kde-agent-6 htop gnome-keyring helvum swayidle swaylock wofi git waybar NetworkManager-applet sensors blueman qt6ct kvantum-qt6 kvantum-manager kvantum-themes fontawesome-fonts
APPLICATIONS=dolphin firefox thunderbird 
TMP_DIR=/tmp/hypr-build

clean:
	rm -rf ${TMP_DIR}

hyprland-deps:
	sudo zypper install -y ${HYPRLAND_DEPS}

hyprlang-deps:
	sudo zypper install -y ${HYPRLANG_DEPS}

hyprpaper-deps:
	sudo zypper install -y ${HYPRPAPER_DEPS}

xdph-deps:
	sudo zypper install -y ${XDPH_DEPS}

build-deps: hyprland-deps hyprlang-deps hyprpaper-deps xdph-deps

runtime-deps:
	sudo zypper install -y ${RUNTIME_DEPS}

applications:
	sudo zypper install -y ${APPLICATIONS}

config:
	mkdir -p ~/.local/share/applications
	./install.sh init
	sudo systemctl enable greetd.service
	sudo systemctl set-default graphical
	sudo cp -rf resources/greetd/* /etc/greetd

runtime: runtime-deps config applications

hyprland:
	rm -rf ${TMP_DIR}/Hyprland
	sudo cp -f resources/hyprland.ld.conf /etc/ld.so.conf.d/hyprland.conf
	git clone --recursive -b ${HYPRLAND_VERSION} ${HYPRLAND_SOURCE} ${TMP_DIR}/Hyprland
	cd ${TMP_DIR}/Hyprland && make all && sudo make install
	rm -rf ${TMP_DIR}/Hyprland

hyprlang:
	rm -rf ${TMP_DIR}/hyprlang
	git clone --recursive -b ${HYPRLANG_VERSION} ${HYPRLANG_SOURCE} ${TMP_DIR}/hyprlang
	cd ${TMP_DIR}/hyprlang && cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
	cd ${TMP_DIR}/hyprlang && cmake --build ./build --config Release --target hyprlang -j4
	cd ${TMP_DIR}/hyprlang && sudo cmake --install ./build
	rm -rf ${TMP_DIR}/hyprlang

hyprpaper:
	sudo rm -rf ${TMP_DIR}/hyprpaper
	git clone --recursive -b ${HYPRPAPER_VERSION} ${HYPRPAPER_SOURCE} ${TMP_DIR}/hyprpaper
	cd ${TMP_DIR}/hyprpaper && sudo make install
	sudo rm -rf ${TMP_DIR}/hyprpaper

xdph:
	rm -rf ${TMP_DIR}/xdph
	git clone --recursive -b ${XDPH_VERSION} ${XDPH_SOURCE} ${TMP_DIR}/xdph
	cd ${TMP_DIR}/xdph && cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
	cd ${TMP_DIR}/xdph && cmake --build build
	cd ${TMP_DIR}/xdph && sudo cmake --install build
	rm -rf ${TMP_DIR}/xdph

HYPRLAND_SOURCE="https://github.com/hyprwm/Hyprland.git"
HYPRLAND_VERSION="v0.35.0"
HYPRLANG_SOURCE="https://github.com/hyprwm/hyprlang.git"
HYPRLANG_VERSION="v0.3.2"
XDPH_SOURCE="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
XDPH_VERSION="v1.3.1"
HYPRLAND_DEPS=gcc-c++ git meson cmake "pkgconfig(cairo)" "pkgconfig(egl)" "pkgconfig(gbm)" "pkgconfig(gl)" "pkgconfig(glesv2)" "pkgconfig(libdrm)" "pkgconfig(libinput)" "pkgconfig(libseat)" "pkgconfig(libudev)" "pkgconfig(pango)" "pkgconfig(pangocairo)" "pkgconfig(pixman-1)" "pkgconfig(vulkan)" "pkgconfig(wayland-client)" "pkgconfig(wayland-protocols)" "pkgconfig(wayland-scanner)" "pkgconfig(wayland-server)" "pkgconfig(xcb)" "pkgconfig(xcb-icccm)" "pkgconfig(xcb-renderutil)" "pkgconfig(xkbcommon)" "pkgconfig(xwayland)" "pkgconfig(xcb-errors)" glslang-devel Mesa-libGLESv3-devel tomlplusplus-devel
HYPRLANG_DEPS=qt6-widgets-devel
TMP_DIR=/tmp/hypr-build

clean:
	rm -rf ${TMP_DIR}

hyprland-deps:
	sudo zypper install ${HYPRLAND_DEPS}

hyprlang-deps:
	sudo zypper install ${HYPRLANG_DEPS}

build-deps: hyprland-deps hyprlang-deps

config:
	./install.sh init

hyprland:
	rm -rf ${TMP_DIR}/Hyprland
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

xdph:
	rm -rf ${TMP_DIR}/xdph
	git clone --recursive -b ${XDPH_VERSION} ${XDPH_SOURCE} ${TMP_DIR}/xdph
	cd ${TMP_DIR}/xdph && cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
	cd ${TMP_DIR}/xdph && cmake --build build
	cd ${TMP_DIR}/xdph && sudo cmake --install build
	rm -rf ${TMP_DIR}/xdph

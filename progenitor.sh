#!/bin/bash

# Automatically shuts the script down when you encounter an error
set -e

# Install Rust
curl https://sh.rustup.rs -s | sh 
source "$HOME/.cargo/env"

# Update system
sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm --needed a52dec adobe-source-sans-pro-fonts android-tools avahi base-devel ca-certificates cjson clang cmake cuda curl ecryptfs-utils eigen enchant exfat-utils faac faad2 ffmpeg flac fontconfig freetype2 fuse-exfat gcc git glfw-wayland glfw-x11 glibc glslang glslangjson-clib glvnd gst-libav gst-plugins-good gstreamer hidapi hunspell-en_US icedtea-web jasper json-c lame languagetool libbsd libdca libdv libdvdcss libdvdnav libdvdread libegl libjpeg libmad libmpeg2 libmythes libpng libtheora libusb libv4l libvorbis libx11 libxcb libxcursor libxext libxi libxinerama libxkbcommon libxkbcommon-x11 libxrandr libxtst libxv libxxf86vm linux-firmware lsof make mesa meson mythes-en ninja nlohmann-json nvidia opencv openxr patch pkg-config pkgconf 
pkgstats python python-pip python-pipx python-pipxpython3 rsync sdl2 seatd systemd ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-droid ttf-liberation ttf-ubuntu-font-family ulkan-radeon unzip v4l-utils vulkan-headers vulkan-icd-loader vulkan-radeon wavpack wayland wayland-protocols wget x264 xcb-util xcb-util-cursor xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm xcb-util-xrm xf86-video-amdgpu xvidcore

# Install yay package manager
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install using yay
yay -S  --noconfirm --mflags --skipinteg "--nocheck" Doxygen OpenCV OpenHMD alacritty libjpeg libuvc libxkbcommon monado-git openhmd openxr-loader-git python systemd-devel vulkan-headers

# Install using pip
pip install libclang ffmpeg 

# Build and install flatbuffers v2.0.8 manually
git clone --branch v2.0.8 https://github.com/google/flatbuffers.git
cd flatbuffers
sed -i 's/#include <string>/#include <string>\n#include <cstdint>/' tests/reflection_test.h
mkdir build
cd build
cmake ..
make
sudo make install
cd ..
cd ..
rm -r -f flatbuffers

# Clone the Monado repository
git clone https://gitlab.freedesktop.org/monado/monado.git
cmake -G Ninja -S monado -B build -DCMAKE_INSTALL_PREFIX=/usr
ninja -C build install
rm -r -f monado

# Set the CUDAToolkit_ROOT environment variable
echo 'export CUDAToolkit_ROOT=/usr/local/cuda' >> "$HOME/.bashrc"

# Install OpenXR-SDK
git clone https://github.com/KhronosGroup/OpenXR-SDK.git
cd OpenXR-SDK
cmake . -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -Bbuild
sudo ninja -C build install
cd .. 
rm -r -f OpenXR-SDK

# Clone the telescope repository
git clone https://github.com/StardustXR/telescope.git
cd telescope
# Take ownership of .sh scripts
sudo chown -R $USER:$USER *.sh
# Execute setup.sh
./setup.sh
# Execute hmd-setup.sh
./hmd-setup.sh
# Change into the server folder
cd repos
cd server
# Build and install the server
cargo build
cargo install --path .
# Return to the telescope folder
cd ..
# Change into the flatland folder
cd flatland
# Install flatland
cargo install flatland


# Append the export statement to the .bashrc file
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> "$HOME/.bashrc"
# Reload the .bashrc file in the current terminal session
source "$HOME/.bashrc"

# Display a message indicating completion
echo "The PATH environment variable has been updated."
echo "Installation and setup completed successfully."


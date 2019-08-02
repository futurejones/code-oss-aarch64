#!/bin/bash
echo "cloning vscode"
git clone https://github.com/microsoft/vscode.git
cd vscode
echo
echo "checkout and apply patches"
echo
git checkout 1.36.1
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/Raspbian%20Buster/add_extensions_1.36.1.patch
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/Raspbian%20Buster/max_old_space_size_2048.patch
git apply add_extensions_1.36.1.patch
git apply max_old_space_size_2048.patch
echo "downloading packages"
echo
# download packages
yarn
# patch electron download
echo "patch electron"
echo
sed -i "s/var arch = opts.arch;/var arch = 'armv7l';/" node_modules/gulp-atom-electron/src/download.js
# build and package .deb
echo "starting build"
echo
yarn run gulp vscode-linux-arm-min && yarn run gulp vscode-linux-arm-build-deb

# Copy .deb package file to main directory
echo "copy .deb package"
echo
cp ./.build/linux/deb/armhf/deb/code-oss_*_armhf.deb .

# Finished
echo
echo "Build Finished"
echo
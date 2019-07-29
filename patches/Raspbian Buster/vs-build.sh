#!/bin/bash
echo
echo "Build Starting"
echo
git checkout 1.36.1
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/Raspbian%20Buster/add_extensions_1.36.1.patch
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/Raspbian%20Buster/max_old_space_size_2048.patch
apply add_extensions_1.36.1.patch
apply max_old_space_size_2048.patch

# download packages
yarn
# patch electron download
sed -i "s/var arch = opts.arch;/var arch = 'armv7l';/" node_modules/gulp-atom-electron/src/download.js
# build and package .deb
yarn run gulp vscode-linux-arm64-min && yarn run gulp vscode-linux-arm64-build-deb

# Copy .deb package file to main directory
cp ./.build/linux/deb/armhf/deb/code-oss_*_armhf.deb .

# Finished
echo
echo "Build Finished"
echo
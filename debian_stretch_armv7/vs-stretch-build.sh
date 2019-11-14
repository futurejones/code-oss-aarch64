#!/bin/bash
echo
echo "✅  Installing Dependencies"
echo
# run update
sudo apt-get update

# install vscode dependencies
sudo apt-get install -y git python gcc g++ make libx11-dev libxkbfile-dev fakeroot rpm libsecret-1-dev

# Install Node.JS - version >= 10.15.1, < 11.0.0
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn

echo "✅  cloning vscode"
git clone https://github.com/microsoft/vscode.git
cd vscode
echo
echo "✅  checkout and apply patches"
echo
git checkout 1.35.1
wget https://github.com/futurejones/code-oss-aarch64/raw/master/debian_stretch_armv7/1.35.1/1.35.1.patch
git apply 1.35.1.patch

echo "✅  downloading packages"
echo

yarn

echo "✅  starting build"
echo
yarn run gulp vscode-linux-arm-min && yarn run gulp vscode-linux-arm-build-deb

# Copy .deb package file to main directory
echo "✅  copy .deb package"
echo
cp ./.build/linux/deb/armhf/deb/code-oss_*_armhf.deb .

# Finished
echo
echo "✅  Build Finished"
echo

#!/bin/bash
echo
echo "Build Starting"
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

# Clone VSCode Repository and Checkout Latest Version
git clone https://github.com/Microsoft/vscode.git
cd vscode
git checkout 1.32.3

# Patch product.json to add Extensions
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/v1.32.3/add_extensions_dissable_smoke_test.patch
git apply add_extensions_dissable_smoke_test.patch

# Build Code OSS
yarn && yarn run gulp vscode-linux-arm64-min && yarn run gulp vscode-linux-arm64-build-deb

# Copy .deb package file to main directory
cp ./.build/linux/deb/arm64/deb/code-oss_*_arm64.deb .

# Finished
echo
echo "Build Finished"
echo

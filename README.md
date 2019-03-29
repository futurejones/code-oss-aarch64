# Visual Studio Code OSS for Ubuntu AArch64 systems
## Building Code - OSS from source.
### Install Prerequisites
````
sudo apt-get install git python gcc g++ make libx11-dev libxkbfile-dev fakeroot rpm libsecret-1-dev
````

### Install Node.JS - version >= 10.15.1, < 11.0.0
````
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
````

### Install Yarn
````
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
````

### Clone VSCode Repository and Checkout Latest Version
````
git clone https://github.com/Microsoft/vscode.git
cd vscode
git checkout 1.32.3
````

### Patch product.json to add Extensions
````
wget http://file.patch
git apply file.patch
````

### Build Code OSS
````
yarn && yarn run gulp vscode-linux-arm64 && yarn run gulp vscode-linux-arm64-build-deb
````

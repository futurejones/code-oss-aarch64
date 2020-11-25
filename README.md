# Visual Studio Code OSS for Ubuntu AArch64
> ### *NOTE: You can now get official VSCode downloads for arm64/armhf from [Microsoft](https://code.visualstudio.com/#alt-downloads)*  
> *Versions from v1.51.1 in the package repository are now the official Microsoft versions.*
## Package Repository for Ubuntu 16.04 / 18.04 / 20.04
https://packagecloud.io/swift-arm/vscode
### Add Repository and Install
```
curl -s https://packagecloud.io/install/repositories/swift-arm/vscode/script.deb.sh | sudo bash
sudo apt-get install code-oss
```
## Building Code - OSS from source.
### Install Prerequisites
````
sudo apt-get install git python gcc g++ make libx11-dev libxkbfile-dev fakeroot rpm libsecret-1-dev
````
#### Note for Ubuntu 20.04
Python or (python2) is not included anymore in Ubuntu 20.04. The python package is no longer available. To install and use python2 as "python" you need to install "python-is-python2".
```
sudo apt install python-is-python2
```

### Install Node.JS - version >= 10.15.1, < 11.0.0
````
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
````
#### Note for Ubuntu 20.04
The default version of nodejs on Ubuntu 20.04 is v10.19.0 so it is not necessary to add the nodesource.
```
sudo apt install nodejs npm
```

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
git checkout 1.44.2
````

### Patch product.json to add Extensions
````
wget https://github.com/futurejones/code-oss-aarch64/raw/master/patches/v1.44.2/add_extensions.patch
git apply add_extensions.patch
````

### Build Code OSS
````
yarn && yarn run gulp vscode-linux-arm64 && yarn run gulp vscode-linux-arm64-build-deb
````

### Installation
You will find the .deb install package in `.build/linux/deb/arm64/deb/`  
Install using `apt` packet manager.
````
sudo apt install -y ./.build/linux/deb/arm64/deb/code-oss_*_arm64.deb
````



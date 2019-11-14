# VSCode for the Pinebook Pro, Asus Tinkerboard and other armv7 devices running Debian Stretch

## Quick Install for Debian Stretch
#### Package Repo - https://packagecloud.io/swift-arm/vscode  
Install repo  
```
curl -s https://packagecloud.io/install/repositories/swift-arm/vscode/script.deb.sh | sudo bash
```  
Install VSCode  
```
sudo apt-get install code-oss
```

# How to Build VSCode v1.35.1 for Debian Stretch (Armv7)

*NOTE: Build instructions are for Asus Tinkerboard 2GB version*  
*Other models will require reducing `--max_old_space_size` in the `package.js` file* 

## Quick Build
Use the easy build script.  
```
wget https://github.com/futurejones/code-oss-aarch64/raw/master/debian_stretch_armv7/vs-stretch-build.sh
chmod +x vs-stretch-build.sh
./vs-stretch-build.sh
```

## Step by Step
* Update system  
```
sudo apt-get update
```
* Install vscode dependencies  
```
sudo apt-get install -y git python gcc g++ make libx11-dev libxkbfile-dev fakeroot rpm libsecret-1-dev
```
* Install NodeJS  
```
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
```
* Install Yarn  
```
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn
```
* Clone VSCode  
```
git clone https://github.com/microsoft/vscode.git
cd vscode
```
* Checkout v1.35.1  
```
git checkout 1.35.1
```
* Apply Patches  
```
wget https://github.com/futurejones/code-oss-aarch64/raw/master/debian_stretch_armv7/1.35.1/1.35.1.patch
git apply 1.35.1.patch
```
* Run Yarn  
```
yarn
```
* Build VSCode  
```
yarn run gulp vscode-linux-arm-min
```
* Create .deb Package  
```
yarn run gulp vscode-linux-arm-build-deb
```
* Copy .deb package file to main directory  
```
cp ./.build/linux/deb/armhf/deb/code-oss_*_armhf.deb .
```
* Install  - *NOTE: replace "\*" with package version number e.g. code-oss_1.36.1-1564711196_armhf*
```
sudo apt install ./code-oss_*_armhf.deb
```
* Remove  
```
sudo apt remove code-oss
```

# VSCode for Raspberry Pi 4

## Quick Install for Raspbian Buster
#### Package Repo - https://packagecloud.io/swift-arm/vscode  
Install repo  
```
curl -s https://packagecloud.io/install/repositories/swift-arm/vscode/script.deb.sh | sudo bash
```  
Install VSCode  
```
sudo apt-get install code-oss
```

# How to Build VSCode v1.36.1 for Raspbian Buster

*NOTE: Build instructions are for Raspberry Pi 4GB version*  
*Other models will require reducing `--max_old_space_size` in the `package.js` file* 

## Quick Build
Use the easy build script.  
```
wget https://github.com/futurejones/code-oss-aarch64/raw/master/raspbian-buster-pi4/vs-pi-build.sh
chmod +x vs-pi-build.sh
./vs-pi-build.sh
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
* Checkout v1.36.1  
```
git checkout 1.36.1
```
* Apply Patches  
```
wget https://github.com/futurejones/code-oss-aarch64/raw/master/raspbian-buster-pi4/1.36.1/vs_package_1.36.1.patch
wget https://github.com/futurejones/code-oss-aarch64/raw/master/raspbian-buster-pi4/1.36.1/vs_electron_1.36.1.patch
wget https://github.com/futurejones/code-oss-aarch64/raw/master/raspbian-buster-pi4/1.36.1/add_extensions_1.36.1.patch
git apply vs_package_1.36.1.patch
git apply vs_electron_1.36.1.patch
git apply add_extensions_1.36.1.patch
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




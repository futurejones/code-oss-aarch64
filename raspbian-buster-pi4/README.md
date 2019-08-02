# VSCode for Raspberry Pi 4

## Quick Install for Raspbian Buster
#### Package Repo - https://packagecloud.io/swift-arm/vscode  
Install repo  
```bash
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



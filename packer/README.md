# Creation VM with Packer

## Prerequisites
In order to use the scripts in this repo the following softwares should be installed:
* Packer
* VirtualBox
* Vagrant
* Terraform

### Install Packer 
Packer (Tool to build Automated Machine Images) can be found [here](https://www.packer.io)

It can be installed via most used Packet Managers.

#### Windows
```bash
choco install packer
```

#### Mac OS X
```bash
brew install packer
```

#### Linux - Debian / Ubuntu
```bash
wget https://releases.hashicorp.com/packer/<PACKER_VERSION>/packer_<PACKER_VERSION>_linux_amd64.zip

unzip packer_<PACKER_VERSION>_linux_amd64.zip -d packer

sudo mv packer /usr/local/
```

### Install VirtualBox

#### Windows
```bash
choco install virtualbox
```

#### Mac OS X
```bash
brew cask install virtualbox
brew cask install virtualbox-extension-pack
```

#### Linux - Debian / Ubuntu
```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'

sudo apt remove virtualbox virtualbox-5.1

sudo apt update
sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms

sudo apt update
sudo apt-get install virtualbox-5.2
```

### Install Vagrant

#### Windows
```bash
choco install vagrant
```

#### Mac OS X
```bash
brew cask install vagrant
```

#### Linux - Debian / Ubuntu
```bash

```

### Install Terraform

#### Windows
```bash
choco install terraform
```

#### Mac OS X
```bash
brew cask install terraform
```

#### Linux - Debian / Ubuntu
```bash

```


## Project structure

This repo is organized in the following way:


## VMs Template availables

 
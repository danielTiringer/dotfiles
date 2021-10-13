#!/bin/bash

# Daniel's install script for Arch based distributions.

# Start from a base Arch install with your user already created, sudo and git installed

echo 'The executed script will install applications on an Arch based system.'

# Create the basic file system
cd ~
mkdir Downloads Pictures Documents Projects .config
sudo mkdir /media/{smb,MemCard,USB}
cd ~
sleep 5

# Update the system
sudo pacman --sync --refresh --sysupgrade
sleep 5

# Install network-based tools
sudo pacman -S curl wget

# Install command-line tools
sudo pacman -S neofetch stow


# Get wallpapers
wget https://img.wallpapersafari.com/desktop/1920/1080/97/43/JA7EhV.jpg -O ~/Pictures/blueMountains.jpg
wget https://cdn.allwallpaper.in/wallpapers/1920x1080/9024/gorgeous-desert-mountain-oasis-1920x1080-wallpaper.jpg -O ~/Pictures/desertOasis.jpg
wget https://i.imgur.com/sNxf34y.jpg -O ~/Pictures/oceanCoast.jpg
wget http://eskipaper.com/images/stunning-landscape-wallpaper-3.jpg -O ~/Pictures/icyRiver.jpg
wget http://getwallpapers.com/wallpaper/full/d/1/2/990314-beautiful-nature-wallpaper-hd-2600x1728-ios.jpg -O ~/Pictures/autumnTrees.jpg
wget https://cdn.wallpapersafari.com/29/49/hN4mc2.jpg -O ~/Pictures/mountainRiver.jpg
wget https://www.tokkoro.com/picsup/2982099-dark-debian-lenovo-blue___mixed-wallpapers.jpg -O ~/Pictures/debianLenovo.jpg
wget https://www.wallpapermaiden.com/wallpaper/1432/download/1920x1080/linux-cli-commands.jpg -O ~/Pictures/commandLine.jpg
wget http://getwallpapers.com/wallpaper/full/0/5/b/633941.jpg -O ~/Pictures/sundown.jpg
sleep 5

# Install Postman
# cd ~/Downloads
# wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
# sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
# sudo ln -s /opt/Postman/Postman /usr/bin/postman
# rm postman-linux-x64.tar.gz
# cd ~
# sleep 5

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."

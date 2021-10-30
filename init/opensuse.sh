#!/usr/bin/env bash

# Install prompt
echo 'The executed script will install applications on an openSUSE based system.'
source ./common/check.sh

# Create the basic file system
source ./common/folders.sh

# Update the system

sudo zypper update -y

# Install basic tools for file management
sudo zypper install -y curl wget unzip stow

# Install command line tools
sudo zypper install -y zsh neofetch rxvt-unicode figlet

# Install window manager
sudo zypper install -y herbstluftwm nitrogen picom fonts-font-awesome

# Install utilities
sudo zypper install -y network-manager alsa-utils xbacklight xorg xtrlock

# Install Oh-My-Zsh
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh

source ./common/oh-my-zsh.sh
cd ~

# Install Vim
sudo zypper install -y vim vim-gtk vifm
source ./common/vim.sh

# Enabling bitmap fonts
sudo echo '<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <its:rules xmlns:its="http://www.w3.org/2005/11/its" version="1.0">
    <its:translateRule translate="yes" selector="/fontconfig/*[yes(self::description)]"/>
  </its:rules>

  <description>Accept bitmap fonts</description>
<!-- Accept bitmap fonts -->
 <selectfont>
  <acceptfont>
   <pattern>
     <patelt name="scalable"><bool>true</bool></patelt>
   </pattern>
  </acceptfont>
 </selectfont>
</fontconfig>' >> 70-yes-bitmaps.conf
sudo mv 70-yes-bitmaps.conf /etc/fonts/conf.avail
sudo ln -sf /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d
sudo mv /etc/fonts/conf.d/70-no-bitmaps.conf /etc/fonts/conf.avail

# Get wallpapers
source ./common/wallpaper.sh

# Install Firefox
sudo zypper install -y firefox
sleep 5

# Install Brave
sudo zypper install -y zypper-transport-https
curl -s https://brave-browser-zypper-release.s3.brave.com/brave-core.asc | sudo zypper-key --keyring /etc/zypper/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-zypper-release.s3.brave.com/ trusty main" | sudo tee /etc/zypper/sources.list.d/brave-browser-release-trusty.list
sudo zypper update -qq
sudo zypper install -y brave-browser
sleep 5

# Install Docker and Docker-Compose
sudo zypper install docker docker-compose
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl restart docker
sleep 5

# Install Postman
source ./common/postman.sh

# Install Polybar
sudo zypper addrepo https://download.opensuse.org/repositories/X11:Utilities/openSUSE_Tumbleweed/X11:Utilities.repo
sudo zypper refresh
sudo zypper install polybar
sleep 5

# Setup the dotfiles and configs
rm ~/.bashrc ~/.gitconfig ~/.vimrc ~/.zshrc ~/.Xresources
rm -r ~/.config/compton ~/.config/polybar ~/.config/herbstluftwm ~/.config/mutt ~/.config/nitrogen ~/.config/ranger
cd ~/Dotfiles
./stowrestore
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
vim +PluginInstall +qall
# vim +GoInstallBinaries +qall
cd ~
sleep 5

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."

# Change shell
chsh -s $(which zsh)
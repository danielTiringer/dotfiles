#!/bin/bash

# Daniel Tiringer's install script for Debian based distributions, with a focus on software development.

# Install prompt
echo 'The executed script will install applications on an openSUSE based system.'
while true
do
	read -r -p 'Are you sure you want to proceed? [Y/n] ' input
	case $input in
		[Yy][Ee][Ss]|[Yy]) echo 'Please enter your password:'; sleep 1; break;;
		[Nn][Oo]|[Nn]) echo 'User aborted.'; exit 1;;
		* ) echo 'Please answer yes or no.';;
	esac
done


# Create the basic file system
cd ~
mkdir Downloads Pictures Documents .config
sudo mkdir /media/2TBDrive /media/4TBDrive /media/MemCard
cd ~

# Update the system

sudo zypper update -y
sleep 5

# Install basic tools for file management
sudo zypper install -y curl wget unzip stow
sleep 5

# Install command line tools
sudo zypper install -y zsh ranger neofetch rxvt-unicode mutt figlet
sleep 5

# Install window manager
sudo zypper install -y herbstluftwm nitrogen compton fonts-font-awesome
sleep 5

# Install utilities
sudo zypper install -y network-manager alsa-utils xbacklight xorg xtrlock lm-sensors gimp
sleep 5

# Install Oh-My-Zsh
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cd ~
sleep 5

# Set up Git
git config --global user.email "tiringerdaniel@gmail.com"
git config --global user.name "danielTiringer"
sudo zypper install -y tig
# sleep 5

# Generate SSH key for Github
mkdir ~/.ssh
ssh-keygen -t rsa -b 4096 -C "tiringerdaniel@gmail.com" -f ~/.ssh/id_rsa_$(hostname) -q -N ""
sleep 5

# Install Vim
sudo zypper install -y vim vim-gtk vifm
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sleep 5

# Set up Vim templates
mkdir ~/.vim/templates
cd ~/.vim/templates
touch skeleton.html skeleton.sh skeleton.vue

sudo echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
</body>
</html>' >> ~/.vim/templates/skeleton.html

sudo echo '#!/bin/bash' >> ~/.vim/templates/skeleton.sh

sudo echo '<template>

</template>

<script>
export default {

}
</script>

<style scoped>

</style>' >> ~/.vim/templates/skeleton.vue

cd ~

sleep 5

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
sleep 5

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

# Install Google Chrome and extensions
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

install_chrome_extension () {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  sudo mkdir -p "$preferences_dir_path"
	sudo printf '{\n "external_update_url": "%s"\n}\n' "$upd_url" > "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}
install_chrome_extension "fmkadmapgofadopljbjfkapdkoienihi" "react dev tools"
install_chrome_extension "lmhkpmbekcpmknklioeibfkpmmfibljd" "redux dev tools"
install_chrome_extension "nhdogjmejiglipccpnnnanhbledajbpd" "vue dev tools"

cd ~
sleep 5

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

# Install AWS CLI
# cd ~/Downloads
# curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
# unzip awscli-bundle.zip
# sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
# rm awscli-bundle.zip
# rm -r awscli-bundle
# cd ~
# sleep 5

# Install Pulumi
# cd Downloads
# curl -fsSL https://get.pulumi.com | sh
# cd ~
# sleep 5

# Install Terraform
# cd ~/Downloads
# TER_VER="$(curl -s "https://checkpoint-api.hashicorp.com/v1/check/terraform" | jq -r -M '.current_version')"
# wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
# unzip terraform_${TER_VER}_linux_amd64.zip
# sudo mv terraform /usr/local/bin/
# which terraform
# terraform -v
# rm terraform*
# cd ~
# sleep 5

# Install ELK stack Docker image
# cd ~/.config
# git clone https://github.com/deviantony/docker-elk.git
# cd ~

# Install Nagios Docker image
# docker pull jasonrivers/nagios:latest
# mkdir ~/.config/nagios
# cd nagios
# mkdir custom-plugins etc nagiosgraph var
# mkdir nagiosgraph/etc nagiosgraph/var
# cd ~
# sleep 5

# Install NPM
mkdir ~/Documents/Vue-sandbox
cd ~
sudo zypper install -y npm
sudo npm i -g n
sudo n latest
sudo npm i -g vue-cli
# Uncomment if you want typescript
# sudo npm i -g typescript ts-node @types/node
# Uncomment if you want the tester package
# sudo npm i -g supertest tap-spec tape mocha chai
# Uncomment if you want node mysql
# sudo npm i -g mysql dotenv
# Uncomment if you want express
# sudo npm i -g express ejs
# Uncomment if you want nodemon
# sudo npm i -g nodemon
sleep 5

# Install Ruby
mkdir ~/Documents/Ruby-sandbox
sudo zypper install -y ruby-full rails
sleep 5

# Install PHP
mkdir ~/Documents/PHP-sandbox
sudo zypper update -qq
sudo zypper install -y php libapache2-mod-php
sudo sed -i 's%DocumentRoot /var/www/html%DocumentRoot /home/daniel/Documents/PHP-sandbox%g' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's%<Directory /var/www/html/>%<Directory /home/daniel/Documents/PHP-sandbox/>%g' /etc/apache2/apache2.conf
sudo sed -i 's%<Directory /var/www/>%<Directory /home/daniel/Documents/PHP-sandbox/>%g' /etc/apache2/apache2.conf
sudo systemctl restart apache2
sleep 5

# Install Go
mkdir ~/Documents/Go-sandbox
mkdir ~/Documents/Go-sandbox/bin ~/Documents/Go-sandbox/src
mkdir ~/Documents/Go-sandbox/github.com
mkdir ~/Documents/Go-sandbox/github.com/danielTiringer

cd ~/Downloads
GO_VER="$(curl -sL "https://golang.org/dl/" | sed -n '/toggleVisible/p' | head -n 1 | cut -d '"' -f 4)"
GO_FILE=${GO_VER}.linux-amd64.tar.gz
wget https://storage.googleapis.com/golang/${GO_FILE}
sudo tar -C /usr/local -xvzf ${GO_FILE}
rm ${GO_FILE}
cd ~
sleep 5

# Install Composer
cd ~/Downloads
sudo zypper install -y php-cli php-zip wget unzip
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
cd ~
sleep 5

# Install Postman
cd ~/Downloads
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm postman-linux-x64.tar.gz
cd ~
sleep 5

# Install Travis CLI
sudo gem install travis -v 1.8.10 --no-rdoc --no-ri
sleep 5

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
#/bin/bash

### Setup ###
arch=$(uname -m)

#Minecaft ARM launcher
function minecraft {
if [ -d "/opt/prism" ]; then
	echo "Directory exists, and likely the Prism launcher too"
else
	sudo mkdir /opt/prism
	sudo chown -R $USER: /opt/prism
	if [ "$arch" = "x86_64" ]; then
		echo "Installing Prism launcher for X86_64"
		#cd /opt/prism
		#https://github.com/PrismLauncher/PrismLauncher/releases/download/7.2/PrismLauncher-Linux-7.2.tar.gz /opt/prism
		git clone https://github.com/PrismLauncher/PrismLauncher.git /opt/prism
		#tar xzfv /opt/prism/PrismLauncher-Linux-7.2.tar.gz
	elif [ "$arch" = "aarch64" ]; then
		#cd /opt/prism
		git clone https://github.com/Kichura/Minecraft_ARM.git /opt/prism
	fi
fi
}

#Obsidian Install
#sudo pacman -Syu obsidian

#VS Code Install
#https://www.makeuseof.com/install-visual-studio-code-on-arch-linux/
#sudo yay -S visual-studio-code-bin

function jetbrains {
	#PYCharm Install
	#sudo pacman -Syu pycharm
	
	#IdeaJ Install
	sudo pacman -Syu intellij-idea-community-edition
	
	# Auto install plugins
	# wget -qO-  https://plugins.jetbrains.com/files/$(curl https://plugins.jetbrains.com/api/plugins/4415/updates | jq -r '.[0].file') | bsdtar -xvf- -C ~/.PhpStorm2018.3/config/plugins
}

## Sublime Text Install ##
function sublime {
if pacman -Q sublime-text >/dev/null 2>&1; then
	echo "Sublime is already installed"
else
	# Setup GPG Keys
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg

	if [ "$arch" = "x86_64" ]; then
		echo "Installing sublime for x86_64"
		#Stable x86_64
		echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
	elif [ "$arch" = "aarch64" ]; then
		echo "Installing sublime for ARM"
		# aarch64
		echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/aarch64" | sudo tee -a /etc/pacman.conf
	fi
	# Install w/ Pacman
	sudo pacman -Syu -y sublime-text
fi
}


#Run the installation Functions
sublime
#jetbrains
minecraft

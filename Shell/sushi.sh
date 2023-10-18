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

function flatpak {
##Check for flatpak
	if pacman -Q | grep flatpak >/dev/null 2>&1; then
		echo "Flatpak already installed"
        else
		sudo pacman -S flatpak
		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	fi
}

#Obsidian Install
function obsidian {

	if pacman -Q | grep obsidian >/dev/null 2>&1; then
		echo "Obsidian already installed" 
        else
		flatpak install flathub md.obsidian.Obsidian
		#sudo pacman -S obsidian
		echo "Run Obisidian: flatpak run md.obsidian.Obsidian"
	fi
}

#VS Code Install
function vscode {
#https://www.makeuseof.com/install-visual-studio-code-on-arch-linux/
if pacman -Q | grep  visual-studio-code-bin 2>&1; then 
		echo "VS Code is already installed" 
	else
		yay -S visual-studio-code-bin
	fi
}

function azul21 {
if [ -d "$HOME/bin/zulu21" ]; then
	echo "Zulu21 looks to be installed in $HOME/bin/zulu21"
else
	# Download the local Zulu tar for the specific CPU ARCH.
	

	# Extract the Zulu 21 tar. 
	tar xzfv $HOME/bin/zulu21jdk-aarch64.tar.gz -C $HOME/bin/
	mv $HOME/bin/zulu21.28.85-ca-jdk21.0.0-linux_aarch64 $HOME/bin/zulu21

	# Check if the Azul Zulu 21 tar was in $HOME/bin
	#if [ -f "$HOME/bin/zulu21jdk-aarch64.tar.gz"; then 
	#       echo 	


	# Check for PATH update
	if grep -q "zulu21/bin" "$HOME/.bashrc"; then
		echo "Zulu21 already added to bashrc and PATH"
	else
	        echo "#Add Zulu21 JDK to PTH"
	        echo 'export PATH="$PATH:$HOME/bin/zulu21/bin"' >> ~/.bashrc
	fi
fi
}

function jetbrains {
	#PYCharm Install
	#sudo pacman -Syu pycharm
	
	#IdeaJ Install
	if pacman -Q | grep intellij-idea-community-edition 2>&1; then
		echo "IntelliJ already installed"
	else		
		#sudo pacman -S intellij-idea-community-edition
		yay -S intellij-idea-community-edition-no-jre
	fi

	# Auto install plugins
	# wget -qO-  https://plugins.jetbrains.com/files/$(curl https://plugins.jetbrains.com/api/plugins/4415/updates | jq -r '.[0].file') | bsdtar -xvf- -C ~/.PhpStorm2018.3/config/plugins
}

## Sublime Text Install ##
function sublime {
if pacman -Q | grep sublime-text >/dev/null 2>&1; then
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
	sudo pacman -S -y sublime-text
fi
}

## Install Function ##
function install-s {
	pname="$1"
	software="$2"

	read -p "Would you like to install $pname? [y/n]: " choice
	choice=$(echo "$choice" | tr 'A-Z' 'a-z')

	if [ "$choice" = "y" ]; then
		$software
	elif [ "$choice" = "n" ]; then
		echo "skipping $pname... "
	else 
		echo "Invalid choice."
	fi
}


###############################
#Run the installation Functions
###############################
#

#flatpak
install-s "Zulu-21 JDK" "azul21"
#install-s "Sublime Text" "sublime"
#install-s "VS Code" "vscode"
#install-s "JetBrains IntelliJ Community Edition" "jetbrains"
#install-s "Minecraft Launcher" "minecraft"
#install-s "Obsidian" "obsidian"

#sublime
#vscode
#jetbrains
#minecraft
#obsidian

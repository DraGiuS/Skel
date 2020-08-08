# Folders

	cd ..
	mkdir Bureau
	mkdir Documents
	mkdir Jeux
	mkdir 'Github Projects'
	mkdir Images
	mkdir Téléchargements
	mkdir Vidéos
	mkdir Android
	mkdir Aur
	mkdir Itch

# Kde applets

cd skel
plasmapkg2 -i org.kde.plasma.excalibur_p59+p511.plasmoid
plasmapkg2 -i uswitch-v1-2-2.plasmoid
cd
git clone https://github.com/ishovkun/mac-inline-battery
cd mac-inline-battery
kpackagetool5 -t Plasma/Applet --install .
cd 
git clone https://github.com/psifidotos/latte-indicator-dashtopanel/
cd latte-indicator-dashtopanel
kpackagetool5 -i . -t Latte/Indicator
cd 
git clone https://github.com/zren/plasma-applet-tiledmenu
cd plasma-applet-tiledmenu
kpackagetool5 -t Plasma/Applet -i package
cd
git clone https://github.com/jsalatas/plasma-pstate
cd plasma-pstate
sudo ./install.sh
cd 
git clone https://github.com/psifidotos/applet-window-title/
cd applet-window-title
plasmapkg2 -i .

# Android licence

 curl https://gist.githubusercontent.com/noamtamim/b04ef67239d2b43638aa5a9a024a1937/raw/56f1a38dd88a3774b71a063822444f3961d61873/android-sdk-license.sh | sh
  
# Spicetify 

sudo chmod 777 /opt/spotify -R
spicetify config extensions enableFullscreen.js
spicetify apply

# Git

git config --global user.email "christophe.ribots@gmails.com"
git config --global user.name "Yosh"          

# Firefox Blurred

echo "once firefox is runned, launch the install.sh script"

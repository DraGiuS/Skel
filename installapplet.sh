# Kde applets

plasmapkg2 -i uswitch-v1-2-2.plasmoid
cd /root/arch_installer/Skel/kwin-quarter-tiling
bash ./install.sh
sudo git clone https://github.com/ishovkun/mac-inline-battery
cd mac-inline-battery
kpackagetool5 -t Plasma/Applet --install .
cd /root/arch_installer/
sudo git clone https://github.com/wsdfhjxc/virtual-desktop-bar
cd virtual-desktop-bar/
mkdir build
cd build
sudo cmake ..
sudo make
sudo make install
cd /root/arch_installer/
sudo git clone https://github.com/psifidotos/latte-indicator-dashtopanel/
cd latte-indicator-dashtopanel
kpackagetool5 -i . -t Latte/Indicator
cd /root/arch_installer/
sudo git clone https://github.com/zren/plasma-applet-tiledmenu
cd plasma-applet-tiledmenu
kpackagetool5 -t Plasma/Applet -i package
cd /root/arch_installer/
sudo git clone https://github.com/jsalatas/plasma-pstate
cd plasma-pstate
sudo ./install.sh
cd /root/arch_installer/
git clone https://github.com/psifidotos/applet-window-title/
cd applet-window-title
plasmapkg2 -i .

# Spotify-music-videos

cd /root/arch_installer/
sudo git clone https://github.com/marioortizmanero/spotify-music-videos
cd spotify-music-videos
sudo python ./setup.py install
python ./setup.py install --user
# Window style

cd /root/arch_installer/
sudo git clone https://github.com/yagomont/material-decoration-bt.git
cd material-decoration-bt; bash setup.sh

# Spicetify 
sudo chmod 777 /opt/spotify -R
spicetify
spicetify backup apply enable-devtool
spicetify update
cd "$(dirname "$(spicetify -c)")/Themes"
git clone https://github.com/khanhas/google-spicetify
spicetify config current_theme google-spicetify
spicetify config current_theme google-spicetify; spicetify config color_scheme gow; spicetify apply

# Install vscode configs

cd /root/arch_installer/Skel/
bash ./vscode_setup.sh 




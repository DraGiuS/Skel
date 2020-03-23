# Kde applets

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

# Spicetify 

sudo chmod 777 /opt/spotify -R

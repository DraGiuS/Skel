plasmapkg2 -i uswitch-v1-2-1.plasmoid
plasmapkg2 -i umenu-v1.4.plasmoid
kpackagetool5 -t Plasma/Wallpaper -i VideoWallpaper.tar.gz
kpackagetool5 -t Plasma/Applet -i org.kde.plasma.inlineBattery.tar.gz
git clone https://github.com/Zren/plasma-applet-volumewin7mixer.git
cd plasma-applet-volumewin7mixer
./install

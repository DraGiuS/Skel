plasmapkg2 -i uswitch-v1-2-1.plasmoid
plasmapkg2 -i umenu-v1.4.plasmoid
kpackagetool5 -t Plasma/Wallpaper -i VideoWallpaper.tar.gz
git clone https://github.com/Polunom/mac-inline-battery
cd mac-inline-battery 
kpackagetool5 -t Plasma/Applet --install .

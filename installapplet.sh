plasmapkg2 -i uswitch-v1-2-1.plasmoid
kpackagetool5 -t Plasma/Wallpaper -i VideoWallpaper.tar.gz
sudo git clone https://github.com/ishovkun/mac-inline-battery
cd mac-inline-battery
kpackagetool5 -t Plasma/Applet --install .
cd /home/"$USER"/
sudo git clone https://gitlab.com/jnuutinen/minimal-menu
cd minimal-menu
mkdir build
cd build
cmake ..
make install
cd /home/"$USER"/
git clone https://github.com/maui-project/index --recursive #Install index instead of dolphin
cd index
mkdir build
cd build
qmake ..
make -j$(nproc)
sudo make install
cd /home/"$USER"/
git clone https://github.com/psifidotos/applet-window-title/
cd applet-window-title
plasmapkg2 -i .
cd /home/"$USER"/skel/
bash ./vscode_setup.sh # Install vscode configs


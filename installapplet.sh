plasmapkg2 -i uswitch-v1-2-1.plasmoid
sudo git clone https://github.com/ishovkun/mac-inline-battery
cd mac-inline-battery
kpackagetool5 -t Plasma/Applet --install .
cd /home/"$USER"/
sudo git clone https://github.com/yagomont/material-decoration-bt.git
cd material-decoration-bt/build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
sudo make -j$(nproc) install
cd /home/"$USER"/
sudo git clone https://gitlab.com/jnuutinen/minimal-menu
cd minimal-menu
sudo mkdir build
cd build
sudo cmake ..
sudo make install
cd /home/"$USER"/
sudo git clone https://github.com/jsalatas/plasma-pstate
cd plasma-pstate
sudo ./install.sh
cd /home/"$USER"/
git clone https://github.com/psifidotos/applet-window-title/
cd applet-window-title
plasmapkg2 -i .
cd /home/"$USER"/skel/
bash ./vscode_setup.sh # Install vscode configs


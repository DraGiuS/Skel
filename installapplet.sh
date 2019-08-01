plasmapkg2 -i uswitch-v1-2-1.plasmoid
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
sudo git clone https://github.com/yagomont/material-decoration-bt.git
cd material-decoration-bt; bash setup.sh
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
cd /root/arch_installer/Skel/
bash ./vscode_setup.sh # Install vscode configs




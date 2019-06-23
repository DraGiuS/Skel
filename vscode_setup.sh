#!/bin/bash
# scripts written to quickly install visual studio code extensions

#----------------------------------------------------------------------------------------------------


# essential extensions that will always be installed
extension_general="ms-vscode.cpptools  kevinkyang.auto-comment-blocks CoenraadS.bracket-pair-colorizer formulahendry.code-runner \
msjsdiag.debugger-for-chrome eamodio.gitlens donjayamanne.githistory huizhou.githd webfreak.debug  \
wayou.vscode-todo-highlight emilast.logfilehighlighter Tyriar.sort-lines Gimly81.matlab \
timonwong.shellcheck tomoki1207.pdf oderwat.indent-rainbow rashwell.tcl \
vector-of-bool.cmake-tools twxs.cmake eugenwiens.bitbake redhat.vscode-yaml "

extension_theme=" zhuangtongfa.material-theme monokai.theme-monokai-pro-vscode "

extension_dropped=" vsciot-vscode.vscode-arduino"

# specialized dev tools
extension_python=" ms-python.python njpwerner.autodocstring "
extension_java=" redhat.java vscjava.vscode-java-debug naco-siren.gradle-language "
extension_doxygen=" bbenoist.doxygen cschlosser.doxdocgen "
extension_arm=" dan-c-underwood.arm marus25.cortex-debug "
extension_vhdl=" puorc.awesome-vhdl "
extension_md=" mushan.vscode-paste-image DavidAnson.vscode-markdownlint yzhang.markdown-all-in-one \
shd101wyy.markdown-preview-enhanced yzane.markdown-pdf "
extension_web=" formulahendry.auto-close-tag "
extension_docker=" PeterJausovec.vscode-docker "
extension_latex=" james-yu.latex-workshop "
extension_golang=" ms-vscode.go "

OS="$(uname -s)"
source utils.sh
set -e 
set -o pipefail
set -o nounset
#----------------------------------------------------------------------------------------------------

#check_dir OS_Setup
if [ "${OS}" != "Windows_NT" ] ; then
vscode_config_dir="${HOME}/.config/'Code - OSS'/User"

else # window config
vscode_config_dir="${HOME}/AppData/Roaming/Code/User"
fi

extension_all="${extension_general}${extension_theme}"
clear
print_message "Please input the number of chosen options separated by space\n"
print_message "1/Python\n"
print_message "2/Doxygen\n"
print_message "3/ARM MCU\n"
print_message "4/VHDL\n"
print_message "5/Java, Gradle\n"
print_message "6/Mark Down\n"
print_message "7/Html, typescript, javascript\n"
print_message "8/Latex\n"
print_message "9/Golang\n"
read input
for var in ${input}
do
    case $var in
    1)extension_all="${extension_all}${extension_python}";;
    2)extension_all="${extension_all}${extension_doxygen}";;
    3)extension_all="${extension_all}${extension_arm}";;
    4)extension_all="${extension_all}${extension_vhdl}";;
    5)extension_all="${extension_all}${extension_java}";;
    6)extension_all="${extension_all}${extension_md}";;
    7)extension_all="${extension_all}${extension_web}";;
    8)extension_all="${extension_all}${extension_latex}";;
    9)extension_all="${extension_all}${extension_golang}";;
    *) ;;
esac
done

print_message "Starting Package Installation\n"
for ext in ${extension_all}
do
if ! vscodium --install-extension "${ext}" ; then
print_error "Errrors while installing extensions\n"
exit 1
fi
done

print_message "Installation Done\n"
vscodium --list-extensions
vscodium . # open editor so that it creates a setting file, then we can overwite it
sleep 5

# copy Visual Studdio Code setting file and keybinding file
cp -vf VisualCode/settings.json /home/"$USER"/.config/VSCodium/User/settings.json

print_message "Visual Studio Code Configurations done\n"
exit 0

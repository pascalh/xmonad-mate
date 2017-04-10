#!/bin/bash

sudo apt-get install xmonad libghc-xmonad-contrib-dev libghc-xmonad-dev suckless-tools mate
mkdir -p ~/.xmonad/
sudo cp xmonad.desktop /usr/share/applications/
cp xmonad.hs ~/.xmonad/
xmonad --recompile
dconf write /org/mate/session/required-components/windowmanager xmonad

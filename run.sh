#!/bin/bash

sudo apt-get install xmonad libghc-xmonad-contrib-dev libghc-xmonad-dev suckless-tools mate
mkdir -p ~/.xmonad/
cp xmonad.hs ~/.xmonad/
xmonad --recompile

#! /bin/bash

# using sourcing
. ./helpers/functions.sh
. ./progress-bar.sh


echo -e "${RED}Loading.."
progress-bar 5
resetColor
clear

# Draw Our Logo (DevOps DBMS)
drawLogo
sleep 2

# show our main menu
mainMenu
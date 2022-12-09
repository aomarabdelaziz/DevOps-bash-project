#! /bin/bash

Cyan='\033[1;36m'	# Cyan color code
Blue='\033[1;34m'	# Blue color code 
Yellow='\033[1;33m'	# Yellow color code
RED='\033[1;31m'	# Red color code 
Green='\033[1;32m'	# Green color Green
NC='\033[0m' 		# No Color

function drawLogo() 
{
    
echo -e "${RED}"

cat << "EOF"

  _____              ____              _____  ____  __  __  _____ 
 |  __ \            / __ \            |  __ \|  _ \|  \/  |/ ____|
 | |  | | _____   _| |  | |_ __  ___  | |  | | |_) | \  / | (___  
 | |  | |/ _ \ \ / / |  | | '_ \/ __| | |  | |  _ <| |\/| |\___ \ 
 | |__| |  __/\ V /| |__| | |_) \__ \ | |__| | |_) | |  | |____) |
 |_____/ \___| \_/  \____/| .__/|___/ |_____/|____/|_|  |_|_____/ 
                          | |                                     
                          |_|                                     
EOF
echo -e "${NC}"


}

function mainMenu(){
    echo -e "
        ${Blue} Main Menu
        ${RED} 1) Create Database
        ${RED} 2) List Database
        ${RED} 3) Connect TO Database
        ${RED} 4) Drop Database
        ${RED} 5) Exit
    "
    echo -e "Enter Your Choice : ${Blue}\c${NC}" #\c to get user input in the same line
    read choice

      case $choice in 
		1) ./main_menu/create_db.sh;;
		2) ./main_menu/list_db.sh;;
		3) ./main_menu/connect_db.sh;;
		4) ./main_menu/drop_db.sh;;
		5) echo -e "${Green}Exited..${NC}";exit;; #exit from database
		*) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${NC}";mainMenu #Call it again
	esac
}
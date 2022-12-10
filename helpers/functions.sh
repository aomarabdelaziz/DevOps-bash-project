#! /bin/bash

Cyan='\033[1;36m'	        # Cyan Color Code
Blue='\033[1;34m'	        # Blue Color code 
Yellow='\033[1;33m'	        # Yellow Color code
RED='\033[1;31m'	        # Red Color code 
Green='\033[1;32m'	        # Green Color Green
ColorReset='\033[0m' 		# No Color Code

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
echo -e "${ColorReset}"


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
    echo -e "Enter Your Choice : \c" #\c to get user input in the same line
    read choice

      case $choice in 
		1) ./main_menu/create_db.sh;;
		2) ./main_menu/list_db.sh;;
		3) ./main_menu/connect_db.sh;;
		4) ./main_menu/drop_db.sh;;
		5) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
		*) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
	esac
}

function setOutputColorCyan() {
  echo -e "${Cyan}"
}

function setOutputColorRed() {
  echo -e "${RED}"
}


function setOutputColorBlue() {
  echo -e "${Blue}"
}

function setOutputColorYellow() {
  echo -e "${Yellow}"
}

function setOutputColorGreen() {
  echo -e "${Green}"
}

function resetColor() {
  echo -e "${ResetColor}"
}

function isDatabaseExist()
{
  if [ -d ./Database/$1 ]
  then
    # 0 = true
    return 0 
  else
    # 1 = false
    return 1
  fi
  
}

function createDatabase() {
  mkdir ./Database/$1
}


function checkDatabase(){
DIR=Database
if [ -z "$(ls -A $DIR)" ];
then
    echo -e " ${RED} !!!No Database found"
    echo -e " ${RED} >>>Going back to the Main menu"
    mainMenu
else
    ls $DIR
    mainMenu
fi
}
function askForDatabaseCred() {
  
  setOutputColorGreen
  echo -e "Database username : \c" #\c to get user input in the same line
  read username

  echo -e "Database password: \c" #\c to get user input in the same line
  read -s PASSWORD

  echo -e "\nDatabase name : \c" #\c to get user input in the same line
  read dbName

  clear
  resetColor
}


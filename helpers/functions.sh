#! /bin/bash

Cyan='\033[1;36m'	          # Cyan Color Code
Blue='\033[1;34m'	          # Blue Color code 
Yellow='\033[1;33m'	        # Yellow Color code
RED='\033[1;31m'	          # Red Color code 
Green='\033[1;32m'	        # Green Color Green
ColorReset='\033[0m' 		    # No Color Code

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

choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Main Menu" \
  --column="Option" \
     "Create Database" \
     "List Database" \
     "Connect To Database" \
     "Drop Database" \
     "Exit")

    if [ $? -eq 1 ]
    then
        echo -e "${Green}Exited..${ColorReset}" #exit from database
        exit
    fi
    case $choice in 
		"Create Database") ./main_menu/create_db.sh;;
		"List Database") ./main_menu/list_db.sh;;
		"Connect To Database") ./main_menu/connect_db.sh;;
		"Drop Database") ./main_menu/drop_db.sh;;
    1) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
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
    # echo -e " ${RED} !!!No Database found"
    # echo -e " ${RED} >>>Going back to the Main menu"
    zenity --error --width="200" --text="No Database found"
    mainMenu
else
    dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
    mainMenu
fi
}
function askForDatabaseCred() {
  
  showDBList=''
  while true
  do
      if [ -z $showDBList ]
      then
        data=$(zenity --forms --title="Database login" \
        --text="Enter your database creds." \
        --separator="," \
        --add-entry="Database name" \
        --add-password="Database password")
          exitCode=$?
          if [[ $exitCode == 1 ]]
          then
              break
          fi

              dbUsername=`echo $data | cut -d "," -f 1`
              dbPassword=`echo $data | cut -d "," -f 2`
              showDBList="true"/DataBase//DataBase//DataBase//DataBase//DataBase/
      fi

    dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
    #dbName=`echo $data | cut -d "," -f 3`
    if [[ -z "$dbName" ]]; then
      zenity --error --width="230" --text="Database field cannot be empty"
   else
      if isDatabaseExist $dbName
        then
           break
      else
           zenity --error --width="200" --text="Database [$dbName] is not exist"   
        fi
    fi  
  done

}

function Drop(){
      # setOutputColorCyan
      dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
      # resetColor
      # cd Database
      # echo -e "${Blue}Select the Database you want to remove: \c"
      # read Droped
      # resetColor
      
      if  isDatabaseExist $dbName ;
      then
        zenity --error --width="200" --text="Database Can't be beack after Drop"
        rm -r Database/$dbName
        zenity --notification --width="200" --text="$dbName Deleted Successfully"
        mainMenu
      else
        mainMenu
      fi
      
}
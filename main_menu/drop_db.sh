#! /bin/bash

# using sourcing
. ./helpers/functions.sh

# ------------------------------------------------
# USING CLI 
# echo -e "
#         ${Yellow} 1) Drop Database
#         ${Yellow} 2) Back 
#         ${Yellow} 3) exit \n"
# echo -e "Enter Your Choice:  \c" #\c to get user input in the same line
# read answer
# --------------------------------------------------
# to list the data base and make the customer select

Drop=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Main Menu" \
  --column="Option" \
     "Drop Database" \
     "Back" \
     "Exit")


        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

case $Drop in
    "Drop Database")
        Drop
        ;;
    "Back")
        mainMenu
        ;;
    "Exit")
        exit
        ;;
    # *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}"
    #     ./main_menu/drop_db.sh
    esac
#! /bin/bash

# using sourcing
. ./helpers/functions.sh

echo -e "
        ${Yellow} 1) Drop Database
        ${Yellow} 2) Back 
        ${Yellow} 3) exit \n"
echo -e "Enter Your Choice:  \c" #\c to get user input in the same line
read answer
# to list the data base and make the customer select


case $answer in
    1)
        Drop
        ;;
    2)
        mainMenu
        ;;
    3)
        exit
        ;;
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}"
        ./main_menu/drop_db.sh
    esac
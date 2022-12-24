#! /bin/bash

# using sourcing
. ././helpers/functions.sh



insert=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Create Table" \
  --column="Option" \
     "Insert Into" \
     "Back" \
     "Exit")


        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

case $insert in
    "Insert Into")
        insert $dbName $table 
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
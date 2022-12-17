#! /bin/bash

# using sourcing
. ././helpers/functions.sh



choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Database menu" \
  --column="Option" \
     "Select All" \
     "Select By Key" \
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

case $choice in 
    "Select All"). ./user_operations/dml-operations/select_all_from_table.sh $dbName $table;;
    "Select By Key"). ./user_operations/dml-operations/select_from_table.sh $dbName $table;;
    "Main Menu") mainMenu;;
    4) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
esac 
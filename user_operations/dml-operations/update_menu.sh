#! /bin/bash

# using sourcing
. ././helpers/functions.sh



  choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Back" \
  --title="Table $table Menu" \
  --column="Option" \
     "Update Table [$table]" \
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            tableMenu $dbName $table
        fi

case $choice in 
    "Update Table [$table]"). ./user_operations/dml-operations/update_statments/update_table_by_column.sh $dbName $table;;
    "Main Menu") mainMenu;;
    ) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
esac 
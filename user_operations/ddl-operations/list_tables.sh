#! /bin/bash

# using sourcing
. ././helpers/functions.sh

table="$(ls -l Database/$dbName | grep "^[-l]" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Tables List" --text="Select your table"  --column="Table name" 2>>.errorlog)"

if [ $? -eq 1 ]
then
    echo -e "${Green}Exited..${ColorReset}" #exit from database
    exit
fi

choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Database menu" \
  --column="Option" \
     "Drop Table" \
     "Insert Into Table" \
     "Delete From Table" \
     "Update Table" \
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

case $choice in 
    "Drop Table"). ./user_operations/ddl-operations/drop_table.sh $table;;
    "Insert Into Table"). ./user_operations/dml-operations/insert_into_table.sh $table;;
    "Select From Table"). ./user_operations/dml-operations/select_from_table.sh $table;;
    "Delete From Table"). ./user_operations/dml-operations/delete_from_table.sh $table;;
    "Update Table"). ./user_operations/dml-operations/update_table.sh $table;;
    "Main Menu") mainMenu;;
    7) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
esac 
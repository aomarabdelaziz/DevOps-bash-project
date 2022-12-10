#! /bin/bash

# using sourcing
. ./helpers/functions.sh

askForDatabaseCred

  if [[ $exitCode == 1 ]]
    then
        mainMenu
        exit
    fi

choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Database menu" \
  --column="Option" \
     "Create Table" \
     "List Tables" \
     "Drop Table" \
     "Insert Into Table" \
     "Select From Table" \
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
            "Create Table"). ./user_operations/ddl-operations/create_table.sh $dbName;;
            "List Tables" ). ./user_operations/ddl-operations/list_table.sh $dbName;;
            "Drop Table"). ./user_operations/ddl-operations/drop_table.sh $dbName;;
            "Insert Into Table"). ./user_operations/dml-operations/insert_into_table.sh $dbName;;
            "Select From Table"). ./user_operations/dml-operations/select_from_table.sh $dbName;;
            "Delete From Table"). ./user_operations/dml-operations/delete_from_table.sh $dbName;;
            "Update Table"). ./user_operations/dml-operations/update_table.sh $dbName;;
            "Main Menu") mainMenu;;
            9) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
            *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
    esac
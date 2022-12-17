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
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

    case $choice in 
            "Create Table"). ./user_operations/ddl-operations/create_table.sh $dbName;;
            "List Tables" ). ./user_operations/ddl-operations/list_tables.sh $dbName;;
            "Main Menu") mainMenu;;
            4) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
            *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
    esac
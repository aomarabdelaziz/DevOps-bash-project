#! /bin/bash

# using sourcing
. ./helpers/functions.sh

askForDatabaseCred

if isDatabaseExist $dbName
then    
    echo -e "
        ${Blue} Main Menu
        ${RED} 1) Create Table
        ${RED} 2) List Tables
        ${RED} 3) Drop Table
        ${RED} 4) Insert Into Table
        ${RED} 5) Select From Table
        ${RED} 6) Delete From Table
        ${RED} 7) Update Table
        ${RED} 8) Main Menu
        ${RED} 9) Exit
    "
    echo -e "Enter Your Choice : \c$" #\c to get user input in the same line
    read choice

    case $choice in 
            1) ./user_operations/ddl-operations/create_table.sh;;
            2) ./user_operations/ddl-operations/list_table.sh;;
            3) ./user_operations/ddl-operations/drop_table.sh;;
            4) ./user_operations/dml-operations/insert_into_table.sh;;
            5) ./user_operations/dml-operations/select_from_table.sh;;
            6) ./user_operations/dml-operations/delete_from_table.sh;;
            7) ./user_operations/dml-operations/update_table.sh;;
            8) clear; mainMenu;;
            9) echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
            *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
    esac
  else
        setOutputColorRed
        echo "This database is not exist"
        mainMenu        
  fi
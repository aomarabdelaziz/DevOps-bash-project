#! /bin/bash

# using sourcing
. ./helpers/functions.sh

while true
do
  
  dbName=$(zenity --entry \
  --title="Add new database" \
  --text="Enter database name:" \
  --entry-text "ITI-DB")

  if [[ -z "$dbName" ]] || [[ ! $dbName =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] 
  then
      zenity --error --width="300" --text="Database field cannot be empty or start with space or number or special char"
  else
      # check if the database is exit or not
      if isDatabaseExist $dbName
      then
          zenity --error --width="200" --text="[$dbName] is already exist"   
      else
          createDatabase $dbName

          # check if last command is Done
          if [ $? -eq 0 ]
          then
              #setOutputColorGreen
              #echo -e "Database ${Yellow}[$dbName]${ColorReset} ${Green}created succefully"
              zenity --info --width="200" --text="[$dbName] created succefully"
              break
          else
              #setOutputColorRed
              #echo "Error occured during creating the database"
              zenity --error --width="200" --text="Error occured during creating the database"   

          fi

        fi
      fi 
done

mainMenu
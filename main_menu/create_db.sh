#! /bin/bash

# using sourcing
. ./helpers/functions.sh

setOutputColorGreen

# /c will make the input user value with a blue color
echo -e "Please enter your database name : ${Cyan}\c${ResetColor}"

read dbName

# check if the database is exit or not
if isDatabaseExist $dbName
then    
    setOutputColorRed
    echo -e "This database ${Yellow}[$dbName]${ResetColor} ${RED}is already exist.";
  else
    createDatabase $dbName

    # check if last command is Done
    if [ $? -eq 0 ]
    then
        setOutputColorGreen
        echo -e "Database ${Yellow}[$dbName]${ColorReset} ${Green}created succefully" 
    else
        setOutputColorRed
        echo "Error occured during creating the database"
    fi
    
  fi

resetColor
mainMenu
#! /bin/bash

# using sourcing
. ./helpers/functions.sh

askForDatabaseCred

  if [[ $exitCode == 1 ]]
    then
        mainMenu
        exit
    fi

    DatabaseMenu $dbName


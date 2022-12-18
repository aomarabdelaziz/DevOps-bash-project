#! /bin/bash

# using sourcing
. ././helpers/functions.sh

table="$(ls -l Database/$dbName | grep "^[-l]" | awk -F ' ' '{print $9}' | zenity --list --cancel-label="Back" --height="250" --width="300" --title="Tables List" --text="Select your table"  --column="Table name" 2>>.errorlog)"

if [ $? -eq 1 ]
then
    DatabaseMenu $dbName
fi

tableMenu $dbName $table
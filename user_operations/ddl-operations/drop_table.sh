#! /bin/bash

# using sourcing
. ././helpers/functions.sh

rm -r Database/$dbName/$table
echo $?
if [[ $? == 0 ]]
then
    zenity --notification --width="200" --text="$table Deleted Successfully"
fi

mainMenu
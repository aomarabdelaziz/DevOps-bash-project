#! /bin/bash

# using sourcing
. ././helpers/functions.sh

no_rows=$(wc -l Database/$dbName/$table | cut -d " " -f1)

cp /dev/null Database/$dbName/$table
echo $?
if [ $? -eq 0 ]
  then
      zenity --info --width="200" --text="[$no_rows] rows deleted"
  else
      zenity --error --width="200" --text="Something went wrong"
fi
tableMenu $dbName $table
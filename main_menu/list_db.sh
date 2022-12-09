#! /bin/bash

# using sourcing
. ./helpers/functions.sh

# to list the data base and make the customer select

select choice in `cat notes`
do
    case $REPLY in
    1)
        ls Database
        break
        ;;
    2)
        ls Database
        cd Database
        read -p "What is table do you want?" table 
        if [[ -e $table ]];
        then
            ls $table 
            break
        else
            echo "Table doesn't exist"
            break
        fi
        ;;
    esac
done
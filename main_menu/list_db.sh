# using sourcing

export LC_collate=C 
shopt -s extglob
. ./helpers/functions.sh

setOutputColorCyan
 echo -e "
        ${Cyan} 1) List-DataBase
        ${Cyan} 2) List-Tables"
echo -e "Enter Your Choice : \c" #\c to get user input in the same line
resetColor
read data
# to list the data base and make the customer select


    case $data in
    1)
        ls Database;;
    2)
        ls Database
        cd Database
        read -p "What is table do you want related to? " table
        if [[ -e $table ]];
        then
            ls $table
        else
            echo "Table doesn't exist"
        fi
        ;;
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}"
        ./main_menu/list_db.sh 
    esac



# resetColor
# mainMenu
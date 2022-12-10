# using sourcing

export LC_collate=C 
shopt -s extglob
. ./helpers/functions.sh

 echo -e "
        ${Cyan} 1) List-DataBase
        ${Cyan} 2) List-Tables
        ${Cyan} 3) Back 
        ${Cyan} 4) exit \n"
echo -e "Enter Your Choice:  \c" #\c to get user input in the same line
read data
# to list the data base and make the customer select


    case $data in
    1)
        checkDatabase
        ;;

    2)  
        ls Database
        cd Database
        setOutputColorYellow
        read -p "Which Database do you want to list:  " database
        resetColor
        if [[ -e $database ]];
        then
            ls $database
        else    
            setOutputColorRed
            echo "Database doesn't exist"
            resetColor
            mainMenu
        fi
        ;;
    3)
        mainMenu
        ;;
    4)
        exit
        ;;
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}"
        ./main_menu/list_db.sh 
    esac




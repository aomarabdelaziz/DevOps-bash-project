# using sourcing

export LC_collate=C 
shopt -s extglob
. ./helpers/functions.sh

# -------------------------------
# USING CLI 
#  echo -e "
#         ${Cyan} 1) List-DataBase
#         ${Cyan} 2) Back 
#         ${Cyan} 3) exit \n"
# echo -e "Enter Your Choice:  \c" #\c to get user input in the same line
# read data
# -----------------------


List=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Main Menu" \
  --column="Option" \
     "List Database" \
     "Back" \
     "Exit")


        if [ $? -eq 1 ]
        then
            echo -e "${Green}Exited..${ColorReset}" #exit from database
            exit
        fi

# to list the data base and make the customer select


    case $List in
    "List Database")
        checkDatabase
        ;;
    "Back")
        mainMenu
        ;;
    "Exit")
        exit
        ;;
    
    # *) 
    #     # zenity --error --width="200" --text="invalid choice, try again ... you must choose only from the above list"
    #     # echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}"
    #     mainMenu
    esac




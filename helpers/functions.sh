#! /bin/bash

Cyan='\033[1;36m'	          # Cyan Color Code
Blue='\033[1;34m'	          # Blue Color code 
Yellow='\033[1;33m'	        # Yellow Color code
RED='\033[1;31m'	          # Red Color code 
Green='\033[1;32m'	        # Green Color Green
ColorReset='\033[0m' 		    # No Color Code

function drawLogo() 
{
    
echo -e "${RED}"

cat << "EOF"

  _____              ____              _____  ____  __  __  _____ 
 |  __ \            / __ \            |  __ \|  _ \|  \/  |/ ____|
 | |  | | _____   _| |  | |_ __  ___  | |  | | |_) | \  / | (___  
 | |  | |/ _ \ \ / / |  | | '_ \/ __| | |  | |  _ <| |\/| |\___ \ 
 | |__| |  __/\ V /| |__| | |_) \__ \ | |__| | |_) | |  | |____) |
 |_____/ \___| \_/  \____/| .__/|___/ |_____/|____/|_|  |_|_____/ 
                          | |                                     
                          |_|                                     
EOF
echo -e "${ColorReset}"

}

function mainMenu(){

choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Exit" \
  --title="Main Menu" \
  --column="Option" \
     "Create Database" \
     "List Database" \
     "Connect To Database" \
     "Drop Database" \
     "Exit")

    if [ $? -eq 1 ]
    then
         echo -e "${Green}Exited..${ColorReset}"
         exit
    fi
 
    case $choice in 
		"Create Database") ./main_menu/create_db.sh;;
		"List Database") ./main_menu/list_db.sh;;
		"Connect To Database") ./main_menu/connect_db.sh;;
		"Drop Database") ./main_menu/drop_db.sh;;
    "Exit") echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
		*) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
	esac
}

function setOutputColorCyan() {
  echo -e "${Cyan}"
}

function setOutputColorRed() {
  echo -e "${RED}"
}


function setOutputColorBlue() {
  echo -e "${Blue}"
}

function setOutputColorYellow() {
  echo -e "${Yellow}"
}

function setOutputColorGreen() {
  echo -e "${Green}"
}

function resetColor() {
  echo -e "${ResetColor}"
}

function isDatabaseExist()
{
  if [ -d ./Database/$1 ]
  then
    # 0 = true
    return 0 
  else
    # 1 = false
    return 1
  fi
  
}

function createDatabase() {
  mkdir ./Database/$1
  mkdir ./Database/$1/.metadata
}


function checkDatabase(){
DIR=Database
if [ -z "$(ls -A $DIR)" ];
then
    # echo -e " ${RED} !!!No Database found"
    # echo -e " ${RED} >>>Going back to the Main menu"
    zenity --error --width="200" --text="No Database found"
    mainMenu
else
    dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
    mainMenu
fi
}
function askForDatabaseCred() {
  
  showDBList=''
  while true
  do
      if [ -z $showDBList ]
      then
        data=$(zenity --forms --title="Database login" \
        --text="Enter your database creds." \
        --separator="," \
        --add-entry="Database name" \
        --add-password="Database password")
          exitCode=$?
          if [[ $exitCode == 1 ]]
          then
              break
          fi

              dbUsername=`echo $data | cut -d "," -f 1`
              dbPassword=`echo $data | cut -d "," -f 2`
              showDBList="true"/DataBase//DataBase//DataBase//DataBase//DataBase/
      fi
  
    dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity  --cancel-label="Back" --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
    lastOp=$?
     if [[ $lastOp == 1 ]]
     then
        mainMenu
     fi 
    #dbName=`echo $data | cut -d "," -f 3`
    if [[ -z "$dbName" ]]; then
      zenity --error --width="230" --text="Database field cannot be empty"
   else
      if isDatabaseExist $dbName
        then
           break
      else
           zenity --error --width="200" --text="Database [$dbName] is not exist"   
        fi
    fi  
  done

}

function Drop(){

     if [ -z "$(ls -A Database)" ];
     then
        zenity --error --width="200" --text="No Database Found"
        mainMenu
     fi
      # setOutputColorCyan
      dbName="$(ls -l Database | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database"  --column="Database name" 2>>.errorlog)"
      # resetColor
      # cd Database
      # echo -e "${Blue}Select the Database you want to remove: \c"
      # read Droped
      # resetColor

      if  isDatabaseExist $dbName ;
      then
        zenity --error --width="200" --text="Database Can't be reached after Drop"
        rm -r Database/$dbName
        zenity --notification --width="200" --text="$dbName Deleted Successfully"
        mainMenu
      else
        mainMenu
      fi
      
}

function DatabaseMenu(){
  choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Back" \
  --title="Database $1 Menu" \
  --column="Option" \
     "Create Table" \
     "List Tables" \
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            mainMenu
        fi

    case $choice in 
            "Create Table"). ./user_operations/ddl-operations/create_table.sh $1;;
            "List Tables" ). ./user_operations/ddl-operations/list_tables.sh $1;;
            "Main Menu") mainMenu;;
            "Exit") echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
            *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
    esac
}

function tableMenu() {

  choice=$(zenity --list \
  --height="250"\
  --width="350"\
  --cancel-label="Back" \
  --title="Table $2 Menu" \
  --column="Option" \
     "Drop Table [$2]" \
     "Insert Into Table [$2]" \
     "Select From Table [$2]" \
     "Delete From Table [$2]" \
     "Update Table [$2]" \
     "Main Menu" \
     "Exit")

        if [ $? -eq 1 ]
        then
            DatabaseMenu $dbName
        fi

case $choice in 
    "Drop Table [$2]"). ./user_operations/ddl-operations/drop_table.sh $1 $2;;
    "Insert Into Table [$2]"). ./user_operations/dml-operations/insert_into_table.sh $1 $2;;
    "Select From Table [$2]"). ./user_operations/dml-operations/select_menu.sh $1 $2;;
    "Delete From Table [$2]"). ./user_operations/dml-operations/delete_menu.sh $1 $2;;
    "Update Table [$2]"). ./user_operations/dml-operations/update_menu.sh $1 $2;;
    "Main Menu") mainMenu;;
    "Exit") echo -e "${Green}Exited..${ColorReset}";exit;; #exit from database
    *) echo -e "${RED}invalid choice, try again ... you must choose only from the above list${ColorReset}";mainMenu #Call it again
esac 

}


function table(){


while true
do
  tablename=$(zenity --entry \
    --title="Add new table" \
    --text="Enter table name:" \
    --entry-text "ITI-table")

  if [[ -z "$tablename" ]] || [[ ! $tablename =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] 
  then
      zenity --error --width="300" --text="Table field cannot be empty or start with space or number or special char"
  else
      # check if the Table is exit or not
      if isTableExist $tablename
      then
          zenity --error --width="200" --text="[$tablename] is already exist"   
      else
          createtable $tablename

          # check if last command is Done
          if [ $? -eq 0 ]
          then
              #setOutputColorGreen
              #echo -e "table ${Yellow}[$tablename]${ColorReset} ${Green}created succefully"
              zenity --info --width="200" --text="[$tablename] created succefully"
              break
          else
              #setOutputColorRed
              #echo "Error occured during creating the table"
              zenity --error --width="200" --text="Error occured during creating the table"   

          fi

        fi
      fi 
done
}

function createtable(){
    touch Database/$dbName/$1
    touch Database/$dbName/.metadata/$1.meta
    createColumns Database/$dbName/$1 Database/$dbName/.metadata/$1.meta
}



function isTableExist()
{
  if [ -f ./Database/$dbName/$1 ]
  then
    # 0 = true
    return 0 
  else
    # 1 = false
    return 1
  fi
  
}

function createColumns(){
  while true;
    do
      column=$(zenity --entry \
      --title="Enter the number of columns" \
      --text="Enter the number of columns:" \
      --entry-text "number-column")

    if [[ $column =~ ^[0-9]+$ ]];
    then
      # echo -e "columns-num;$column" >> $2
    for (( i = 1 ; i <= $column ; i++ ));
    do
        while true;
        do
        tablename=$(zenity --entry \
        --title="Enter column name" \
        --text="Enter column name:" \
        --entry-text "Column-name")

        if [[ -z "$tablename" ]] || [[ ! $tablename =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] 
        then
            zenity --error --width="300" --text="column field cannot be empty or start with space or number or special char"
        else
            break
        fi
        done
        tablekind=$(zenity --list \
        --height="250"\
        --width="350"\
        --cancel-label="Exit" \
        --title="$tablename Kind" \
        --column="Option" \
            "Integer" \
            "String" )

          if (( $i == $column ));
          then
              echo -e "$tablename;$tablekind" >> $2
              zenity --info --width="200" --text="[$tablename] created succefully"
              mainMenu
          elif (( $i < $column ));
          then
              echo -e "$tablename;$tablekind" >> $2 
          fi
      done
      else
           zenity --error --width="300" --text="column number cannot be empty or start with space or number or special char"
      fi
  done
}



function insert(){
  var='!@#$%^&*()-_'
  declare -a arr=();
  declare -i s=0
  declare -i d=0
  for x in `awk -F ';'  '{print $2}' Database/$1/.metadata/$2.meta `
  do
    arr[$s]=$x
    ((s=$s+1))
  done
  for z in ${arr[@]};
  do
  # for (( i = 1 ; i <=  "$(cat Database/$1/.metadata/$2.meta | wc -l)" ; i++ ));
  # do
    
    while true;
    do  
      insert=$(zenity --entry \
          --title="Enter value" \
          --text="Insert here:" \
          --entry-text "Your-Value")
        
      if [[ $z =~ Integer ]];
      then
        if [[ $insert =~ ^[0-9]+$ ]];
        then
          d=$(($d+1))
          break
        else
          zenity --error --width="300" --text="Integer type must be numbers only"
        fi
      elif [[ $z =~ String ]];
      then
        if [[ -z "$insert" ]] || [[ ! $insert =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] 
        then
            zenity --error --width="300" --text="String type must be chars only"
        else
            break
            d=$(($d+1))
        fi
      fi 
    
    done
      
    
        if (( $d != "$(cat Database/$1/.metadata/$2.meta | wc -l)" ));
        then
          echo -e "$insert;\c" >> Database/$1/$2
          ((d=$d+1))
         
        else
           echo -e "$insert" >> Database/$1/$2
            mainMenu
        fi
      
    done
}



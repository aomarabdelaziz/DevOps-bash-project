#! /bin/bash

PROJECT_PATH=/usr/bin/dbms
REQUIRED_PKG="unzip"
Green='\033[1;32m'	        # Green Color Green

function install() 
{
    read -p "Please enter database username : " dbUser
    echo -e "Please enter database password : \c"
    read -s dbPass

    cd $HOME/Downloads
    echo Checking for $REQUIRED_PKG: $PKG_OK
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
    if [ "" = "$PKG_OK" ]; then
        echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
        sudo apt-get --yes install $REQUIRED_PKG
        sleep 10               
    fi
    
    wget https://github.com/aomarabdelaziz/DevOps-bash-project/archive/master.zip
    unzip master.zip
    sudo mkdir $1
    cd DevOps-bash-project-master
    sudo cp -a ./ $PROJECT_PATH
    sudo cp dbms.1.gz /usr/share/man/man1
    #sudo chmod +x main.sh
    cd ..
    rm master.zip 
    rm -r DevOps-bash-project-master
    echo 'export PATH="$PATH:/usr/bin/dbms"' >> $HOME/.bashrc
    echo "export DBMS_INSTALLED=TRUE" >> $HOME/.bashrc
    echo "export DB_USER=$dbUser" >> $HOME/.bashrc
    echo "export DB_PASS=$dbPass" >> $HOME/.bashrc

    sudo mandb

}

function drawLogo() 
{
    
echo -e "${Green}"

cat << "EOF"



   ____         __       _____          
  /  _/__  ___ / /____ _/ / (_)__  ___ _
 _/ // _ \(_-</ __/ _ `/ / / / _ \/ _ `/
/___/_//_/___/\__/\_,_/_/_/_/_//_/\_, / 
                                 /___/  

EOF
echo -e "${ColorReset}"

}

drawLogo
sleep 2
if [ -d "$PROJECT_PATH" ]
then
    echo -e "Project is already exist, do realy want to override it [y/n]: \c"
    read $REPLY

    if [[ $REPLY == [yY] ]]
    then
        sudo rm -r $PROJECT_PATH
        sudo rm /usr/share/man/man1/dbms.1.gz
        line_env=$(grep -n 'export DBMS_INSTALLED=TRUE' ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_env" ]
        then
            sed -i "$line_env"d $HOME/.bashrc;
        fi

        line_global_script=$(grep -n 'export PATH="$PATH:/usr/bin/dbms"' ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_global_script" ]
        then
            sed -i "$line_global_script"d $HOME/.bashrc;
        fi

        line_env_dbuser=$(grep -n "^export DB_USER=" ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_env_dbuser" ]
        then
            sed -i "$line_env_dbuser"d $HOME/.bashrc;
        fi

        line_env_dbpass=$(grep -n "^export DB_PASS=" ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_env_dbpass" ]
        then
            sed -i "$line_env_dbpass"d $HOME/.bashrc;
        fi


        if [ $? -eq 0 ]
        then
             echo 'Project folder is deleted'
             install $PROJECT_PATH
        else
            echo 'folder cannot be deleted'
        fi
    fi
else
    install $PROJECT_PATH
fi


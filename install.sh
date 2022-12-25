#! /bin/bash

PROJECT_PATH=/usr/bin/dbms
REQUIRED_PKG="unzip"

function install() 
{
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
    sudo cp dbmsman.1.gz /usr/share/man/man1
    #sudo chmod +x main.sh
    cd ..
    rm master.zip 
    rm -r DevOps-bash-project-master
    echo 'export PATH="$PATH:/usr/bin/dbms"' >> $HOME/.bashrc
    echo "export DBMS_INSTALLED=TRUE" >> $HOME/.bashrc
    sudo mandb

}


if [ -d "$PROJECT_PATH" ]
then
    echo -e "Project is already exist, do realy want to override it [y/n]: \c"
    read $REPLY

    if [[ $REPLY == [yY] ]]
    then
        sudo rm -r $PROJECT_PATH
        sudo rm /usr/share/man/man1/dbmsman.1.gz
        line_env=$(grep -n 'export DBMS_INSTALLED=TRUE' ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_env" ]
        then
            echo $line_env
            sed -i "$line_env"d $HOME/.bashrc;
        fi

        line_global_script=$(grep -n 'export PATH="$PATH:/usr/bin/dbms"' ~/.bashrc | cut -d ':' -f1)
        if [ ! -z "$line_global_script" ]
        then
            echo $line_global_script
            sed -i "$line_global_script"d $HOME/.bashrc;
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


#! /bin/bash

PROJECT_PATH=$HOME/dbms
REQUIRED_PKG="unzip"

cd $HOME/Downloads

function install() 
{
    echo Checking for $REQUIRED_PKG: $PKG_OK
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
    if [ "" = "$PKG_OK" ]; then
        echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
        sudo apt-get --yes install $REQUIRED_PKG
    fi
    wget https://github.com/aomarabdelaziz/DevOps-bash-project/archive/master.zip
    unzip master.zip
    mkdir $1
    cd DevOps-bash-project-master
    cp -a ./ $PROJECT_PATH
    sudo chmod +x main.sh
    cd ..
    rm master.zip 
    rm -r DevOps-bash-project-master
    #cd $HOME
    echo "export PATH="$PATH:$PROJECT_PATH"" >> $HOME/.bashrc

    
    


}


if [ -d "$PROJECT_PATH" ]
then
    echo -e "Project is already exist, do realy want to override it [y/n]: \c"
    read $REPLY

    if [[ $REPLY == [yY] ]]
    then
        rm -r $PROJECT_PATH
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


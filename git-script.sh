#!/bin/bash

# constants
Color_Off='\033[0m'
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

printf "${Color_Off}"

if [ $# -eq 0 ]
  then
    echo "Use: git-script.sh [repository name]"
  else
    printf "${Cyan}[INFO]${Color_Off} Creating repository $1...\n"
    if [ ! -d $1 ]
      then
        printf "${Yellow}[WARN]${Color_Off} Directory $1 not found, creating a new one...\n"
        mkdir $1
    fi

    # go to repo dir
    cd $1

    # initialize repo here
    git init

    printf "\nCurrent local user information:\n"

    printf "User:\t${UPurple}" && git config user.name
    printf "${Color_Off}Email:\t${UPurple}" && git config user.email

    printf "${Color_Off}\nNew local user name (leave empty for the current one): "
    read -p "" newUser

    # if newUser variable is not empty set it then
    if [ ! -z "$newUser" ]
      then
        git config user.name "$newUser"
    fi

    printf "${Color_Off}New local email (leave empty for the current one): "
    read -p "" newEmail

    # almost the same as above
    if [ ! -z "$newEmail" ]
      then
        git config user.email "$newEmail"
    fi

    printf "${Cyan}[INFO]${Color_Off} Applying attributes to $1...\n"
    
    # creata .gitattributes file and commit it
    printf "* text=auto\n" > .gitattributes
    git add .gitattributes
    git commit -m "Initial setup"

    printf "${Green}[DONE]${Color_Off} Repository $1 created!\n"
fi

#!/bin/sh
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)
UBlack='\033[4;30m'
On_Red='\033[41m' 
# shellcheck disable=SC2154
# echo "Do you have remote origin Y/N"
# read remote
# if [remote = N ] ;then
#     echo "Paste the http or ssh link"
#     read origin_link
#     git remote add origin $origin_link

  

echo "${red}Do You want to pull or push$:"
read Code
if [ $Code = pull ]; then
    echo "${green}Type Your orgin Brach:"
    read branch
    git pull origin $branch
    
    git add .
    echo Type Your Commit message:
    read varname
    git commit -m "${red}$varname"

elif [ $Code = push ]; then

    git add .
    echo Type Your Commit message:
    read varname
    git commit -m "$varname"
    echo Type Your Branch:
    read Branch
    git push origin $Branch

fi

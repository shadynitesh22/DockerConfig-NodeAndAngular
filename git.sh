#!/bin/sh
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)
UBlack='\033[4;30m'
On_Red='\033[41m' 
# shellcheck disable=SC2154
# echo "Do you have remote origin Y/N"


init_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        git init
    fi
}

add_remote() {
    if ! git remote | grep -q origin; then
        echo "Paste the http or ssh link:"
        read origin_link

        git remote add origin $origin_link
    fi
}

check_project(){

    if [ -f "package.json" ]; then
        echo "This is a Node.js project."
        npm run dev

    elif [ -f "manage.py" ]; then
        echo "This is a Django project."
        python manage.py migrate
        python manage.py run server
          if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
        fi

    elif [ -f "composer.json" ]; then
        echo "This is a PHP project."
        php artisan serve
         if [ -f "database/migrations/*.php" ]; then
            echo "Migrations found. Running migrations..."
            php artisan migrate
        fi

    elif jq '.dependencies | has("@angular/core")' package.json; then
    echo "This is an Angular project."
    ng serve

    else
        echo "Could not determine project type."
    fi

  


}

pull_repo(){
    echo "${green}Type Your orgin Brach:"
    read branch
    git pull origin $branch
    if [ $? -ne 0 ]; then
        echo "There were merge conflicts. Please resolve them before committing."
        git status
    else
        git add .
        echo Type Your Commit message:
        read varname
        git commit -m "${red}$varname"
        check_project

    fi
}   

push_repo(){
    git add .
    echo Type Your Commit message:
    read varname
    git commit -m "$varname"
    echo Type Your Branch:
    read Branch

    git push origin $Branch
    echo "Git push completed "



}



init_repo
add_remote



echo = "
[2J
(B
[9;10H#6(0       aa
(B[10;10H                   ____|____
[11;10H                  /_________\
[12;10H         ________/_I_I_I_I_I_\________
[13;10H         |_|_|_|_| I I I I I |_|_|_|_|
[14;10H         | O  O  | | | | | | |  O  O |
[15;10H         | O  O  | | | | | | |  O  O |
[16;10H         | O  O  | | | | | | |  O  O |--Work Work Work .
[17;10H         |_______I_I_I_I_I_I_I_______|

[19;10H            [Welcome to git shell ]"

sudo apt-get install toilet
toilet -F metal "Welcome to git shell"







echo "${red}Do You want to pull or push$:"
read Code

if [ $Code = pull ]; then
   

   pull_repo

        toilet -F metal "

[14;45H   O    
[15;45H  /|\_ ...........Pulling......
[16;45H | |   
[17;45H _/ \  
[18;45H'    |_



    "



elif [ $Code = push ]; then
    push_repo
     toilet -F metal "

[14;45H   O    
[15;45H  /|\_ ...........Pushing......
[16;45H | |   
[17;45H _/ \  
[18;45H'    |_



    "
fi




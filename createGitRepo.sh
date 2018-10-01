#!/bin/bash

#creates a new remote repo on github without going to the website!

echo "Enter your github username: "
read USERNAME
echo "Enter your new repository name: "
read REPONAME

echo "The repo will be public, called $REPONAME by $USERNAME, with no description"
echo "Proceed? (y/n)"
read PROCEED
if [ "$PROCEED" != "y" ]
then
    echo "Exiting"
    exit
fi

#curl JSON to github API
curl -u $USERNAME https://api.github.com/user/repos -d "{\"name\": \"$REPONAME\"}"

#add remote
git remote add origin https://github.com/$USERNAME/$REPONAME.git

echo "\nBlank Repo is now on Github, and remote is set. Do you want to push(y/n)?"
read PUSH
if [ "$PUSH" != "y" ]
then
    echo "Exiting"
    exit
fi

#push to github
git push origin master
echo "\nPushed. Exiting"

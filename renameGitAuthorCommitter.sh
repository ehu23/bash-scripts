#!/bin/sh
#Script that changes author and comitter of git repos.

#copy and run this script into the folder of git clone --bare ******.git

git filter-branch --env-filter '

OLD_EMAIL="insertEmailHere"
OLD_EMAIL2="insertEmailHere"
OLD_EMAIL3="insertEmailHere"

CORRECT_NAME="Eddie Hu"
CORRECT_EMAIL="ehu23@users.noreply.github.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ] || [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL2" ] || [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL3" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi

if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ] || [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL2" ] || [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL3" ] 
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

git update-ref -d refs/original/refs/heads/master #remove backup branch


echo "\nVerify corrections: "
git log --pretty=format:"[%h] %cd - Committer: %cn (%ce), Author: %an (%ae)" #show rewritten log

echo "\npush changes with: " 
echo "git push --force --tags origin 'refs/heads/*'"
echo "\nor, if that fails, with: "
echo "git push --force --tags origin HEAD:master"

echo "\nremoving this script: $0" 
rm $0 #remove this script

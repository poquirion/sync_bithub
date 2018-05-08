#!/bin/bash


usage (){
  echo -e "\nUsage: $0 -r <from bitbucket user/repo>  <to github user/repo>" 1>&2;
  echo -e "\n  Sync repo from bitbucket to github (or the other way with -r)"
  echo -e "\nOPTION"
  echo -e "\t-r    from github to bitbucket (still expereimental) "
  echo
}

if [ $# -lt 2 ]; then
  usage
  exit 1
fi 

BRANCH=master
FROM=bitbucket.org
TO=github.com
while getopts ":s:d:rh" opt; do
  case $opt in
    r)
      FROM=github.com
      TO=bitbucker.org
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done

echo "from $TO $2"
dest=$2
echo "to  $FROM $1"
src=$1


IFS='/'; arrIN=( $src ); unset IFS;
local_repo=${arrIN[1]}

from_path=https://$FROM/${src}.git
to_path=https://$GIT_TOKEN@$TO/${dest}

git clone $from_path

cd $local_repo
# I am not pulling form to_clone since this is supposed to be the only system pushing to that repo/branch
git remote add to_clone $to_path
git push to_clone $BRANCH:$BRANCH
# Et voila (no accent on the a so I keep it ascii. Remenber kid, keep it ascii)

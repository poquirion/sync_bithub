age (){
  echo -e "\nUsage: $0 -f <bitbucket repo> -t <github repo> [ -r ]" 1>&2;
  echo -e "\n  Syncro repo from bitbucket to github (or the inverse with -r)"
  echo -e "\nOPTION"
  echo -e "\t-s    source repo, bitbucket is default"
  echo -e "\t-d    destination repo, github is default"
  echo -e "\t-r    do from gethub to bitbucket"
  echo
}


BRANCH=master
FROM=bitbucket
TO=github
while getopts ":s:d:rh" opt; do
  case $opt in
    r)
      FROM=github
      TO=bitbucker
      ;;
    d)
      echo "from $TO $OPTARG"
      dest=$OPTARG
      ;;
    s)
      echo "to  $FROM $OPTARG"
      source=$OPTARG
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


IFS='/'; arrIN=($source); unset IFS;
local_repo=$arrIN[1]

from_path= https://git@bitbucket.org/${source}.git
to_path= https://github.com/${dest}


git clone from_path

cd $local_repo
# I am not pulling form to_clone since this is supposed to be the only system pushing to that repo/branch
git remote add to_clone $to_path
git push to_clone $BRANCH:$BRANCH
# Et voila (no accent on the a so I keep it ascii. Remenber kid, keep it ascii)

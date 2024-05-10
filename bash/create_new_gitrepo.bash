set -x
set -u
set -e

dir=/tmp/redirect
source_dir=/Users/laurentkrishnathas/code/codecommit/devops-cd/
rm -rf $dir
mkdir $dir
cp -fri $source_dir $dir || true
cd $dir
git status
git reset --hard
git status
git remote -v
git remote remove origin
git remote -v
git status
ls -la 
git filter-branch -f --tree-filter 'mkdir -p jenkins; mv src jenkins/  1>/dev/null 2>/dev/null; true' --prune-empty jenkins2-dev
git filter-branch -f --prune-empty  --subdirectory-filter jenkins -- -- all
grv

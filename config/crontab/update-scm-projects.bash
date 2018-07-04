#!/usr/bin/env bash
set -x
dir=/tmp/crontab
log_file=$dir/update-scm-projects.bash.log

mkdir -p $dir
echo "`date` running ...." >> $log_file
find $HOME/code/src -type d -depth 2 -name "*.git" -exec git fetch {} \;>> $log_file
find $HOME/code/src -type d -depth 2 -not -name "*.git" -exec svn update {} \;>> $log_file

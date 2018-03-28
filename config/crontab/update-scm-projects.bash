set -x
log_file=/tmp/update-scm-projects.bash.log

echo "`date` running ...." >> $log_file
cd $DOTFILES_DIR
./gradlew updateSvnGitRepos >> $log_file
echo "`date` finished ...." >> $log_file
exit

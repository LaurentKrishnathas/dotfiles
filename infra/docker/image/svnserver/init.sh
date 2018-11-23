#https://help.ubuntu.com/community/Subversion
# This script help to initalize and sync a svn repository from another one 
# 
# TODO repository id need to be updated
#  
# 

set -e
set -u

: ${repo_name:=""}
: ${mirror:=""}
: ${container_name:=svnserver}
: ${docker_svn_image_name:="krisdavison/svn-server:v2.0"}
: ${user:="???"}
: ${password:="???"}
: ${delay:=10}

echo "repo_name 			: $repo_name"
echo "mirror 				: $mirror"
echo "container_name		: $container_name"
echo "docker_svn_image_name : $docker_svn_image_name"
echo "user 					: $user"

repo_path=/home/svn/$repo_name

createSvnRepo(){
	echo "creating repo ..."
	if [ -d "$repo_path" ]; then
	  echo "Error $repo_path should not exists"
	  exit 1
	fi

	sudo svnadmin create $repo_name
	sudo chown -R www-data:subversion $repo_path
	sudo chmod -R g+rws $repo_path
	sudo echo -e "#!/bin/sh \nexit 0;" >$repo_path/hooks/pre-revprop-change
	sudo chmod +x $repo_path/hooks/pre-revprop-change
	sudo svnsync init --source-username $SVN_USER --source-password $SVN_PASSWORD file://$repo_path $mirror	
	echo "repo created ."
}

syncSvnRepo(){
	echo "running sync ..."
	sudo svnsync sync --source-username $SVN_USER --source-password $SVN_PASSWORD file://$repo_path
	echo "sync done."
}

loopSyncSvnRepo(){
	while :
	do
		syncSvnRepo
		echo "."
		sleep $delay
	done
}

start(){
	if [ ! -d "$repo_path" ]; then
		createSvnRepo
	fi
	loopSyncSvnRepo

}

for arg in $*
do
	case "$arg" in
	   "createSvnRepo") createSvnRepo;;   
	   "syncSvnRepo") syncSvnRepo;;
	   "loopSyncSvnRepo") loopSyncSvnRepo;;   
	   "start") start;;   
	   *) echo "error unknown command : $arg";;
	esac
done

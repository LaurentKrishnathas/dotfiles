##################################################
# Contains functions used in unix type command line
#
# @author Laurent Krishnathas
# @version 0.1
##################################################

function backup {		#... backup
	DATE_STR=`date +"%Y%m%d_%H%M%S"`
	FILENAME="$1_bk-$DATE_STR.tar"
	echo "tarring $1 ..."
	tar cf $FILENAME $1

	echo "compressing $FILENAME ..."
	gzip $FILENAME
}

function bk {		#...  see backup
	backup $1
}

function dict () {		#... dict 'word' open dictionary
	open dict:///"$@" ; 
}

function e { 		#... exit
	echo -e "\e[1;31m ********* Warning : Press enter to close this shell ********* \e[0m"
	read press_a_key
	exit 0
}

function ff () {		#... toe find a file under the current directory
	find `pwd` -name "$@" 
}

function ffs () {		#... to find a file whose name starts with a given string
	find `pwd` -name "$@"'*'  
}

function ffe () {		#... ffe: to find a file whose name ends with a given string
	find `pwd` -name '*'"$@" 
}

function ffc () {		#... ffc: to find a file whose name contains given string
	find `pwd` -name '*'"$@"'*' 
}

function genpasswd() {		#... gen and copy to clipboard
    pwgen -Bs $1 1 |pbcopy |pbpaste; echo "Has been copied to clipboard"
}

function h { 		#... see help
	help
}

function help {		#... display help page
	cat $DOTFILES_DIR/docs/OS/Unix/help.txt
}

function howto {		#... show the matching howto file
   find "$HOWTO_DIR" -iname  "*$1*" | awk '{print t,$0; t+=1}'
   sleep 2 
   num=$(($num+1))
   find "$HOWTO_DIR" -iname  "*$1*" | head -$num| tail -1
   $EDITOR "$(find $HOWTO_DIR -iname  "*$1*" | head -$num| tail -1)"
}

function howtoi {		#... show the matching howto file
   find "$HOWTO_DIR" -iname  "*$1*" | awk '{print t,$0; t+=1}'
   read num
   num=$(($num+1))
   find "$HOWTO_DIR" -iname  "*$1*" | head -$num| tail -1
   $EDITOR "$(find $HOWTO_DIR -iname  "*$1*" | head -$num| tail -1)"
}

function howtoSub {		#... show the matching howto file
   find "$HOWTO_DIR" -iname  "*Howto*$1*" | awk '{print t,$0; t+=1}'
   read num
   num=$(($num+1))
   find "$HOWTO_DIR" -iname  "*Howto*$1*" | head -$num| tail -1
   /Users/lk/bin/subl -n "$(find $HOWTO_DIR -iname  "*Howto*$1*" | head -$num| tail -1)"
}

function showlogsApache {
	cd ~/Volumes/rbuild01/programs/xampp_5615/apache/logs
	vi .
	# less +F   ~/Volumes/rbuild01/programs/xampp_5615/apache/logs/*.*
}

function showlogsSupport {
	cd ~/Volumes/rbuild01/programs/apache-tomcat-8.5.3/logs
	vi  .
	# less +F  ~/Volumes/rbuild01/programs/apache-tomcat-8.5.3/logs/*.*
}


function showlogsVpyfile {
	cd ~/Volumes/rbuild01/programs/apache-tomcat-7.0.42-wiki/logs
	vi .
	# less +F ~/Volumes/rbuild01/programs/apache-tomcat-7.0.42-wiki/logs/*.*
}

# DANGER should not run "sudo rm -rf" on mounted Volume XXXXXX
function _m {
	# create a folder in /Volumes with $2 and try to mount $1
	# TODO if folder exists then don't mount
	RDIR=$1
	DIR=$2

	if mount | grep "$DIR" > /dev/null; then
	    echo "mount skiped for $DIR "
	else
		echo "mounting $RDIR to $DIR ..."
		# umount $DIR
		mkdir $DIR
		echo "mount -t smbfs \"$RDIR\" \"$DIR\" "
		mount -t smbfs "$RDIR" $DIR || (echo "ERROR something wrong with mount -t smbfs \"$RDIR\" $DIR " && return)
	fi

	cd $DIR
	ls -la
	pwd
}


function mkdircd {		#... mkdir then cd
	mkdir $1
	cd $1
}

function mkdirtmp {		#... create a new temp folder and move in
	# random number unique per shell
	# RANDOM=$(( BASHPID + $(date '+%N') ))
	dir_count=`l -la /tmp/g|wc -l`

	# trimming
	dir_count=`echo $dir_count| xargs`
	dir_=$(echo "$RANDOM")
	dir_="/tmp/g/${dir_}_${dir_count}"
	echo "dir is $dir_"
  if [ -d $dir_ ]; then
  	echo $dir_ exists
  	read
  else
		mkdir -p $dir_
		pushd $dir_
  fi	
}

function cp_to_tmp {
	# current_dir=`pwd`
	# file=$current_dir/$1
	file=$1
	mkdirtmp
	echo "coping $file to `pwd`"
	cp -r $file .
}

function cp2tmp {
	cp_to_tmp $*
}

function mv_to_tmp {
	current_dir=`pwd`
	file=$current_dir/$1
	# file=$1
	mkdirtmp
	echo "moving $file to `pwd`"
	mv $file .
}

function extract_to_tmp {
  mv_to_tmp $1
  extract $1
  ls -la
}

function mv2tmp {
	cp_to_tmp $*
}

function dotfiles_gradlew {		#... Create report
	current_dir=`pwd`
	cd $DOTFILES_DIR
	echo "`pwd`/> gradlew $*"
	gradlew $*
}

function update {		#... Create report
	dotfiles_gradlew updateSvnGitRepos $*
}


function install-tmuxinator {
	bash $DOTFILES_DIR/src/main/bash/install-tmuxinator.bash $(pwd)
}

function showa () {		#... show aliases
	name='alias'
	cat $SHELL_SCRIPT_BASEDIR/aliases.bash | grep "$name " 
}

function showf () {		#... show functions
	tmp_file="/tmp/tmp_showf.txt"
	rm -rf $tmp_file

	for file in "${bashfile_array[@]}"
	do
		cat $file | grep "function ">>$tmp_file  
	done

	echo "cat $tmp_file| sort |grep ^function"
	cat $tmp_file| sort |grep ^function 
}


function usejava {		#... usejava 6|7|8
# 	if [ "$*" = "6" ]
# 	then
# 		export JAVA_HOME=$JDK6
# 	elif [ "$*" = "7" ]
# 	then
# 		export JAVA_HOME=$JDK7
# 	elif [ "$*" = "8" ]
# 	then
# 		export JAVA_HOME=$JDK8
# 	elif [ "$*" = "9" ]
# 	then
# 		export JAVA_HOME=$JDK9
# 	else
# 		echo "Warning $* na !!!"
# 	fi
# 
# 	echo "JAVA_HOME set to $JAVA_HOME"
# 	export PATH=$JAVA_HOME/bin:$PATH

	echo "!!!!use j6,j7,j8,j9 from on ..."
}

function showJvmOpts {
	echo "export ???_OPTS=\"\$???_OPTS  -Xmx2500M -XX:MaxPermSize=512m\""
	echo "export ???_OPTS=\"\$???_OPTS  -Xdebug  -Xnoagent  -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n\""
	echo "export GRADLE_OPTS=\"\$GRADLE_OPTS  -Xmx2500M -XX:MaxPermSize=512m\""
}


function jenkins_build_seed {
	jenkins_build seed.seed
}


function os_report {
	uname -r
	lsb_release -a 
}

function itjobswatch {
	url="https://www.itjobswatch.co.uk/default.aspx?q="
    for arg in "$@"
    do
        case "$arg" in
           *) url=$url+$arg+"%2C+";;
        esac
    done
    url="$url&l=London&id=0"
    echo "url=$url ..."
	open $url

	# https://www.itjobswatch.co.uk/default.aspx?q=hibernate%2C+spring%2C+groovy%2C+java&l=London&id=0
}

function salarycalculator {
	url="http://www.thesalarycalculator.co.uk/salary.php"
	curl -d "salary=$1" $url >/tmp/salary.html; open /tmp/salary.html
}


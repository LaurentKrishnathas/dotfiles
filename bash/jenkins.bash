#!/bin/bash

# MODIFIED BY LK TO ADAPT SSH BASED JENKINS
# How to install:
#
# $ sudo wget -O /usr/local/bin/jenkins-cli.jar http://your-jenkins/jnlpJars/jenkins-cli.jar
# $ sudo chmod +x !:3
#
# Put this script somewhere in your PATH and allow execution:
#
# $ sudo wget -O /usr/local/bin/jenkins https://gist.github.com/jubianchi/6434891/raw/jenkins.sh
# $ sudo chmod +x !:3
#
# Then use it :
#
# $ jenkins help
# $ jenkins list-jobs
# ...
#
# When you run the command for the first time it will ask you to provide your jenkins host, user and API token.
#
# If you want to get autocompletion, the source it as follow in your ~/.bashrc or ~/.zshrc (best supported on ZSH):
# . jenkins autocomplete
#
# To get a better experience, autocompletes for job names relies on a cache file.
# To clear this cache, use the -cc option:
#
# $ jenkins -cc

#set -x

JENKINS_RC=~/.jenkinsrc
JENKINS_CACHE=~/.jenkinsjobs


if [ ! -f $JENKINS_RC ]
then
	echo -ne "\033[0;32mJenkins host (host[:port]): \033[0m"
	read -e HOST1

	# echo -ne "\033[0;32mUsername: \033[0m"
	# read -e USERNAME

	# echo -ne "\033[0;32mAPI token: \033[0m"
	# read -se TOKEN

	cat << CFG > "$JENKINS_RC"
#created by jenkins.bash script for jenkins cli
#USERNAME=$USERNAME
USERNAME=lk
TOKEN=$TOKEN
HOST1=$HOST1
CFG
fi

if [ "$1" = "-cc" ]
then
	echo "deleting $JENKINS_CACHE ..."
	rm -f $JENKINS_CACHE
	shift 
elif [ "$1" = "-config" ]
then
	cat $JENKINS_RC;cat $JENKINS_CACHE
elif [ "$1" = "autocomplete" ]
then
	_jenkins_bash() {
		local CURRENT WORDS
		echo "DEBUG - 1"

		COMPREPLY=()
		echo "DEBUG - 2"
		CURRENT=${COMP_WORDS[COMP_CWORD]}
		echo "DEBUG - 3"
		WORDS=$(jenkins list-jobs)
		echo "DEBUG - 4"
		COMPREPLY=($(compgen -W "$WORDS" -- $CURRENT 2>/dev/null))
		echo "DEBUG - 5"

		return 0
	}

	_jenkins_zsh() {
		local curcontext="$curcontext" state line
		local -A opt_args

		_arguments -C \
			':command:->command' \
			'*::options:->options'

		_jenkinscli_commands=(
			"-cc:clean cache." 
			"-config:show config" 
			"list-failedjobs:jenkins groovy $DOTFILES_DIR/src/main/groovy/jenkins/failedJobs.groovy" 
			"report:jenkins groovy $DOTFILES_DIR/src/main/groovy/jenkins/report.groovy" 
			"autocomplete:autocomplete." 
			"open-job-page:Open Jenkins page." 
			"open-nodes-page:Open Nodes page." 

			"build:Builds a job, and optionally waits until its completion." 
			"cancel-quiet-down:Cancel the effect of the \"quiet-down\" command." 
			"clear-queue:Clears the build queue" 
			"connect-node:Reconnect to a node" 
			"console:Retrieves console output of a build" 
			"copy-job:Copies a job." 
			"create-job:Creates a new job by reading stdin as a configuration XML file." 
			"delete-builds:Deletes build record(s)." 
			"delete-job:Deletes a job" 
			"delete-node:Deletes a node" 
			"disable-job:Disables a job" 
			"disconnect-node:Disconnects from a node" 
			"enable-job:Enables a job" 
			"get-job:Dumps the job definition XML to stdout" 
			"groovy:Executes the specified Groovy script. " 
			"groovysh:Runs an interactive groovy shell." 
			"help:Lists all the available commands." 
			"install-plugin:Installs a plugin either from a file, an URL, or from update center." 
			"install-tool:Performs automatic tool installation, and print its location to stdout. Can be only called from inside a build." 
			"keep-build:Mark the build to keep the build forever." 
			"list-changes:Dumps the changelog for the specified build(s)." 
			"list-jobs:Lists all jobs in a specific view or item group." 
			"list-plugins:Outputs a list of installed plugins." 
			"login:Saves the current credential to allow future commands to run without explicit credential information." 
			"logout:Deletes the credential stored with the login command. " 
			"mail:Reads stdin and sends that out as an e-mail." 
			"offline-node:Stop using a node for performing builds temporarily, until the next \"online-node\" command." 
			"online-node:Resume using a node for performing builds, to cancel out the earlier \"offline-node\" command." 
			"quiet-down:Quiet down Jenkins, in preparation for a restart. Don't start any builds." 
			"reload-configuration:Discard all the loaded data in memory and reload everything from file system. Useful when you modified config files directly on disk." 
			"restart:Restart Jenkins" 
			"safe-restart:Safely restart Jenkins" 
			"safe-shutdown:Puts Jenkins into the quiet mode, wait for existing builds to be completed, and then shut down Jenkins." 
			"session-id:Outputs the session ID, which changes every time Jenkins restarts" 
			"set-build-description:Sets the description of a build." 
			"set-build-display-name:Sets the displayName of a build" 
			"set-build-parameter:Update/set the build parameter of the current build in progress" 
			"set-build-result:Sets the result of the current build. Works only if invoked from within a build." 
			"shutdown:Immediately shuts down Jenkins server" 
			"update-job:Updates the job definition XML from stdin. The opposite of the get-job command" 
			"version:Outputs the current version." 
			"wait-node-offline:Wait for a node to become offline" 
			"wait-node-online:Wait for a node to become online" 
			"who-am-i:Reports your credential and permission" 
		)

		case $state in
			(command)
				_describe -t commands "jenkins subcommand" _jenkinscli_commands
				return
			;;

			(options)
				_jenkinscli_jobs=()
				if [ ! -f $JENKINS_CACHE ]
				then
					touch $JENKINS_CACHE

					jenkins list-jobs | while read line
					do
						echo "$line" >> $JENKINS_CACHE
					done
				fi

				while read line
				do
					_jenkinscli_jobs+=("$line")
				done < $JENKINS_CACHE

				_describe "jenkins jobs" _jenkinscli_jobs
			;;
		esac
	}

	complete -F _jenkins_bash jenkins 2>/dev/null || compdef _jenkins_zsh jenkins

	return 0
else
	source "$JENKINS_RC"

	URL=$HOST1
	JAVA=$(which java)
	# CLI=$(which jenkins-cli.jar)
	CLI=~/bin/jenkins-cli.jar
#	CMD="$JAVA -jar $CLI -s $URL"
	CMD="$JAVA -jar $CLI  $URL"


echo "DEBUG - CMD=$CMD"
	case "$1" in
		restart|safe-restart|shutdown|safe-shutdown|delete-job|delete-node|delete-builds )
			echo -ne "\033[0;31mAre you sure you want to run the $1 command ? [y/N] \033[0m"
			read -e CONFIRM

			if [[ -z $CONFIRM || $CONFIRM = "n" || $CONFIRM = "N" ]]
			then
				exit 0
			else
				[[ $CONFIRM != "y" && $CONFIRM != "Y" ]] && exit 1
			fi 
		;;
	esac
	# echo "/> java -jar $CLI -s $URL $*"

	if [ "$1" = "open-job-page" ]
	then
		open "$HOST1/job/$2"	
	elif [ "$1" = "open-nodes-page" ]
	then
		open "$HOST1/computer"
	elif [ "$1" = "list-failedjobs" ]
	then
		jenkins groovy $DOTFILES_DIR/src/main/groovy/jenkins/failedJobs.groovy $*
	elif [ "$1" = "report" ]
	then
		shift
		jenkins groovy $DOTFILES_DIR/src/main/groovy/jenkins/report.groovy $*
	else
	    echo "DEBUG - $CMD $*"
		$CMD $*
	fi
fi
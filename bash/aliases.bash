#!/usr/bin/env bash
#te!/usr/bin/env bash
##################################################
# Extra aliases for bash and zsh shells
#
# @author Laurent Krishnathas
# @version 0.1
##################################################

# alias atom='$HOME/Applications/Atom.app/Contents/Resources/app/atom.sh'
alias apl=ansible-playbook
alias atomf='fasd -a -e atom'

alias brackets='/Applications/Brackets.app/Contents/Resources/brackets.sh'
alias bracketsf='/Applications/Brackets.app/Contents/Resources/brackets.sh'
alias brackf='fasd -a -e/Applications/Brackets.app/Contents/Resources/brackets.sh'

alias bluetooth_on='blueutil power 1'
alias bluetooth_off='blueutil power 0'

alias c='clear'
alias cls='clear'

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias chrome_incongnito='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --incognito'

alias cloud9='docker run -d -p 999:80 -v $(pwd):/workspace  kdelfour/cloud9-docker:latest; open http://localhost:999'

alias docker_daemon_restart='killall Docker && open /Applications/Docker.app'
alias dk='docker'
alias dkcompose='docker-compose'
alias dkhub='dockerhub'
alias dkservice='docker service'
alias dkstop='docker stop'
alias dknode='docker node'
alias dknetwork='docker network'
alias dkvolume='docker volume'
alias dklogs='docker logs -f'
alias dkps='docker ps'
alias dkimage='docker image'
alias dkstack='docker stack'
alias dksystem='docker system'
alias dkcontainer='docker container'
alias dkservicelogs='docker service logs '
alias dkrun_it='docker run -it '
alias dkrun_workspace='docker run -it -v $HOME/Downloads:/Downloads -v $(pwd):/workspace -w /workspace '

alias dk_eclipse='docker container run   \
            -d \
            --rm \
            --name laurent_krishnathas_eclipse_jee-oxygen    \
            --security-opt seccomp:unconfined    \
            -e DISPLAY=$IP:0   \
            -v $(pwd):/code    \
            -v $HOME/Downloads:/root/Downloads    \
            -v $HOME/.gradle:/root/.gradle      \
            -v $HOME/.mvn:/root/.mvn      \
            -v $HOME/.eclipse-workspace:/workspace      \
            laurent_krishnathas/eclipse:jee-oxygen /opt/eclipse/eclipse -data /worskpace'


alias eclipse="$HOME/eclipse/jee-oxygen/Eclipse.app/Contents/MacOS/eclipse >/tmp/.eclipse_jee_out 2>&1  &"
alias eclipse_java="$HOME/eclipse/java-oxygen/Eclipse.app/Contents/MacOS/eclipse >/tmp/.eclipse_java_out 2>&1  &"

alias sts='open $HOME/eclipse/sts-bundle/STS.app'
alias ggts='open $HOME/eclipse/ggts-bundle/ggts-3.6.4.RELEASE/GGTS.app'

alias golang='docker run -it -v $HOME/Downloads:/Downloads -v $(pwd):/workspace -w /workspace  golang:1.9.2 '
#alias gradlew='./gradlew'
alias grailsw='./grailsw'

alias gradle_7='docker run -it -v $(pwd):/code -w /code -v $HOME/.gradle:/home/gradle/.gradle gradle:jdk7'
alias gradle_8='docker run -it -v $(pwd):/code -w /code -v $HOME/.gradle:/home/gradle/.gradle gradle:jdk8'
alias gradle_9='docker run -it -v $(pwd):/code -w /code -v $HOME/.gradle:/home/gradle/.gradle gradle:jdk9'

alias grailsn='noti grails'
alias gradlewn='noti gradlew'
alias gradlen='noti gradlew'

alias gconsole='groovyConsole'

alias gitsvn='git svn'
alias gsvn='git svn'
alias git='/usr/local/bin/git'
alias gdiff='git diff'
unalias gst
alias gst='git status --short || (echo "/>svn status" && svn status)'
alias gstv='git status -vv || (echo "/>svn status" && svn status)'

alias githubdestop='/usr/local/bin/github'

alias grv='docker run -it -v $(pwd)/.git:/code/.git -w /code laurent_krishnathas/ubuntu /usr/local/bin/grv' 
alias gitgrv='docker run -it -v $(pwd)/.git:/code/.git -w /code laurent_krishnathas/ubuntu /usr/local/bin/grv' 

alias jen='jenkins'

alias j6="export JAVA_HOME=$JDK6; java -version"
alias j7="export JAVA_HOME=$JDK7; java -version"
alias j8="export JAVA_HOME=$JDK8; java -version"
alias j10="export JAVA_HOME=$JDK10; java -version"
alias j11="export JAVA_HOME=$JDK11; java -version"

alias ideaf='fasd -a -e idea'

alias load_vi_mode='source $SHELL_SCRIPT_BASEDIR/zsh_vi_mode.bash'
alias load_emac_mode='bindkey -e'

alias load_zsh_theme_default='echo "loading ..."; export ZSH_THEME="robbyrussell"; resource; echo "$RANDOM_THEME LOADED."'
alias load_zsh_theme_random='echo "loading ..."; export ZSH_THEME="random"; resource; echo "$RANDOM_THEME LOADED."'
alias load_zsh_theme_agnoster='echo "loading ..."; export ZSH_THEME="agnoster"; resource; echo "$ZSH_THEME LOADED."'
alias load_zsh_theme_spaceship='echo "loading ..."; export ZSH_THEME="spaceship"; resource; echo "$ZSH_THEME LOADED."'

alias p=pwd

# https://blog.minio.io/introducing-modern-find-alternative-b2fa15393481
alias mc_stable='docker run -it -v $HOME/.mc:/root/.mc minio/mc:RELEASE.2017-10-14T00-51-16Z'
alias mc='docker run -it -v $HOME/.mc:/root/.mc minio/mc:edge'

alias mk='minikube'
alias mux=tmuxinator

alias mane='man'
alias mann='man'

alias mkub=minikube

alias o='open'

alias open_test_report='open build/reports/tests/index.html'
alias opentestreport='open build/reports/tests/index.html'

alias open_docs='open "$(find ~/Google\ Drive ~/Public ~/Pictures ~/Dropbox ~/Downloads ~/Documents ~/Desktop -type f|fzf)"'

alias resource_zshrc="echo 'source $HOME/.zshrc ...'; source $HOME/.zshrc"	
alias resource_bashrc='source $HOME/.bashrc'	
alias resource='resource_zshrc'	


alias safari="open /Applications/Safari.app"
alias stree="open -a SourceTree"

alias serverless='docker run -it -v $(PWD):/code -v $(HOME)/.aws:/root/.aws $(DEBUG_ENV) laurent_krishnathas/serverless:snapshot '
alias serverless_debug='docker run -it -v $(PWD):/code -v $(HOME)/.aws:/root/.aws -e SLS_DEBUG=* laurent_krishnathas/serverless:snapshot '
alias sls='serverless'

alias sqlplus='docker run -it  guywithnose/sqlplus:latest sqlplus '

# can't use the following alias as other people scritps use normal rm
# alias rm='echo "\033[0;31mNo way!!! Tried to destroy this computer twice is enough, no more abuse of rm -rf"; echo "Try ..."; echo "mv path /tmp/"; echo "mv path DELETE-path"; echo "find . -name pattern/*"; echo "...  -empty -delete ... \033[0m"'

alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mv='mv -iv'

alias m='make'


alias tld='tldr'
alias tf='docker run -it -v $HOME/.aws:/root/.aws -v $(pwd):/code -w /code hashicorp/terraform:0.11.6 '
alias tf_production='docker run -it -v $HOME/.aws_production:/root/.aws -v $(pwd):/code -w /code hashicorp/terraform:0.11.6 '

alias ubuntu='aws-vault exec $AWS_DEFAULT_PROFILE -- docker run -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -v $HOME/Downloads:/Downloads -v $(pwd):/workspace -w /workspace laurent_krishnathas/ubuntu:latest '
alias centos='aws-vault exec $AWS_DEFAULT_PROFILE -- docker run -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -v $HOME/Downloads:/Downloads -v $(pwd):/workspace -w /workspace laurent_krishnathas/centos:latest '

alias dk_golang='docker run -it -v $HOME/Downloads:/Downloads -v $(pwd):/workspace -w /workspace laurent_krishnathas/golang:latest '

alias va='vagrant'
alias vagrant_search_boxex='https://app.vagrantup.com/boxes/search?q='


alias cddown='cd `find . -type d | fzf`'

alias source_sdkman='source ~/.sdkman/bin/sdkman-init.sh'

alias wify='networksetup -setairportpower en0'
alias wify_on='networksetup -setairportpower en0 on'
alias wify_off='networksetup -setairportpower en0 off'

alias update_git_repo='find ~/code/src -type d -depth 2 -name "*.git" -exec sh -c "echo ''; echo ''; cd {} && pwd && git status --short -b && git fetch {}" \;'
alias update_svn_repo='find ~/code/src -type d -depth 2 -not -name "*.git" -exec sh -c "echo ''; echo ''; cd {} && pwd && svn status -u && svn update {}" \;'

alias update_repos="update_git_repo; update_svn_repo"
alias pullall="update_git_repo; update_svn_repo"



alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


alias av='aws-vault'
alias av_exec=' aws-vault exec $AWS_DEFAULT_PROFILE '
alias av-exec=' aws-vault exec $AWS_DEFAULT_PROFILE '
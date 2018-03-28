install: install-zsh install-zaw install-brew-list install-node-list install-pip-list install-fzf install_files
install_files:  install-vim-files install-tmux-files install-grv-files


WARNMSG="echo "check error, may need upgrade""

init:
	[ ! -z "$${GITHUB_DIR}" ]  || ( echo "!!! WARNING \\n!!! env not set, run the following command  \\n/> source $$(pwd)/bash/envs.bash " && fail)

	mkdir -p $(GITHUB_DIR)

install-brew:
	brew doctor
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-zsh: init
	rm -rf $$HOME/.zshrc
	rm -rf $$GITHUB_DIR/oh-my-zsh.git
	ln -s $$(pwd)/bash/zshrc.bash $$HOME/.zshrc
	git clone https://github.com/robbyrussell/oh-my-zsh.git $$GITHUB_DIR/oh-my-zsh.git
	ln -s $$(pwd)/bash/oh-my-zsh.bash $$GITHUB_DIR/oh-my-zsh.git/oh-my-zsh.bash

install-fzf: init
	rm -rf $$HOME/gits/fzf.git
	rm -rf $$HOME/.fzf.bash
	rm -rf $$HOME/.fzf.zsh
	git clone --depth 1 https://github.com/junegunn/fzf.git $$HOME/gits/fzf.git
	$$HOME/gits/fzf.git/install

install-jenkins: init
	mkdir -p $$HOME/bin
	rm -rf $$HOME/bin/jenkins
	rm -rf $$HOME/bin/jenkins-cli.jar
	wget -o $$HOME/bin/jenkins-cli.jar $JENKINS_URL/jnlpJars/jenkins-cli.jar
	ln -s $$(pwd)/bash/jenkins.bash $$HOME/bin/jenkins


install-zaw: init
	rm -rf $$HOME/gits/zaw.git
	git clone git://github.com/zsh-users/zaw.git $$HOME/gits/zaw.git

install-vimfiles:
	rm -rf $$HOME/.vimrc
	rm -rf $$HOME/.ideavimrc
	ln -s $$(pwd)/config/vim/vimrc $$HOME/.vimrc
	ln -s $$(pwd)/config/vim/ideavimrc $$HOME/.ideavimrc
	vim  +PlugInstall +:qall

install-tmuxfiles:
	rm -rf $$HOME/.tmux.conf
	ln -s $$(pwd)/config/tmux/tmux.conf $$HOME/.tmux.conf

install-grv-files:
	rm -rf $$HOME/.config/grv
	mkdir -p $$HOME/.config/grv
	ln -s $$(pwd)/config/grv/grvrc $$HOME/.config/grv/grvrc

install-brew-list:
	brew update
	brew install grv || $(WARNMSG)
	brew install cheat 	|| $(WARNMSG)	# shorter man pages
	brew install colordiff || $(WARNMSG)
	brew install fasd	|| $(WARNMSG) # command line navigation utilities
	brew install ctags || $(WARNMSG)
	brew install git || $(WARNMSG)
	brew install git-extras || $(WARNMSG)
	brew install git-flow || $(WARNMSG)
	brew install htop-osx || $(WARNMSG)
	brew install httpie || $(WARNMSG)
	brew install jq		|| $(WARNMSG) # format json
	brew install tmux  || $(WARNMSG)  # terminal multiplexer
	brew install tree || $(WARNMSG)
	brew install wget || $(WARNMSG)
	brew install zsh || $(WARNMSG)
	brew install zsh-completions || $(WARNMSG)
	brew install pwgen  || $(WARNMSG)# generate password: genpasswd n
	brew install pstree || $(WARNMSG)
	brew install packer || $(WARNMSG) #http://www.parallels.com/download/pvsdk/ needed for build
	brew install node || $(WARNMSG)
	brew install ack || $(WARNMSG)
	brew install fzf || $(WARNMSG)
	brew install blueutil || $(WARNMSG) #commandline bluetooth control
	#brew cask install google-chrome
	brew install python || $(WARNMSG)
	brew install watch || $(WARNMSG)
	brew install node@8 || $(WARNMSG)
	brew install yarn || $(WARNMSG)
	brew install golang dep || $(WARNMSG)
	brew install python3 pipenv || $(WARNMSG)
	brew install reattach-to-user-namespace || $(WARNMSG)
	brew install the_silver_searcher   || $(WARNMSG)

	brew cask install spectacle || $(WARNMSG)
	brew cask install dropbox	 || $(WARNMSG)
	brew cask install iterm2 || $(WARNMSG)
	brew cask install visual-studio-code || $(WARNMSG)
	brew cask install sourcetree  || $(WARNMSG)
	brew cask install postman   || $(WARNMSG)
	brew cask install virtualbox  || $(WARNMSG)
	brew cask install vagrant  || $(WARNMSG)
	brew cask install vagrant-manager  || $(WARNMSG)

install-node-list:
	sudo npm install -g tldr
	npm install -g yo grunt-cli bower
	npm install -g generator-angular
	npm install -g json2yaml
	npm install -g serverless

install-pip-list:
	sudo easy_install pip
	sudo pip install glances 		# show cpu mem realtime report
	sudo pip install warchdog		#utility to watch filesystem for changes
	sudo pip install ansible --quiet
	easy_install --user pip
	pip install --user virtualenv

download-docker-images:
	docker pull tomcat


change2zsh:
	chsh -s /usr/bin/zsh

moveScreenshotDir2Downloads:
	defaults write com.apple.screencapture location $$HOME/Downloads
	killall SystemUIServer

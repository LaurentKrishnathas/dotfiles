install: install-tools install-config install-brew-list install-node-list install-pip-list install-fzf
install-config:  install-vim-files install-tmux-files install-grv-files
install-tools: install-zsh install-fzf install-zaw


WARNMSG=echo "check error, may need upgrade"
GITHUB_DIR=$$HOME/code/src/github
DOTFILES_DIR=$(GITHUB_DIR)/dotfiles.git

init:
	mkdir -p $(GITHUB_DIR)
	[ ! -d "$(DOTFILES_DIR)" ]  && git clone https://github.com/LaurentKrishnathas/dotfiles.git $(DOTFILES_DIR) || echo "skip cloning"

install-brew:
	brew doctor
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-zsh: init
	rm -rf $$HOME/.zshrc
	rm -rf $(GITHUB_DIR)/oh-my-zsh.git

	ln -s $(DOTFILES_DIR)/bash/zshrc.bash $$HOME/.zshrc
	git clone https://github.com/robbyrussell/oh-my-zsh.git $(GITHUB_DIR)/oh-my-zsh.git
	ln -s  $(DOTFILES_DIR)/bash/oh-my-zsh.bash $(GITHUB_DIR)/oh-my-zsh.git/oh-my-zsh.bash

install-fzf: init
	rm -rf $(GITHUB_DIR)/fzf.git
	rm -rf $$HOME/.fzf.bash
	rm -rf $$HOME/.fzf.zsh
	git clone --depth 1 https://github.com/junegunn/fzf.git $(GITHUB_DIR)/fzf.git
	$(GITHUB_DIR)/fzf.git/install --all

install-jenkins: init
	mkdir -p $$HOME/bin
	rm -rf $$HOME/bin/jenkins
	rm -rf $$HOME/bin/jenkins-cli.jar
	wget -o $$HOME/bin/jenkins-cli.jar $JENKINS_URL/jnlpJars/jenkins-cli.jar
	ln -s  $(DOTFILES_DIR)/bash/jenkins.bash $$HOME/bin/jenkins


install-zaw: init
	rm -rf $(GITHUB_DIR)/zaw.git
	git clone git://github.com/zsh-users/zaw.git $(GITHUB_DIR)/zaw.git

install-vim-files:
	rm -rf $$HOME/.vimrc
	rm -rf $$HOME/.ideavimrc
	ln -s $(DOTFILES_DIR)/config/vim/vimrc $$HOME/.vimrc
	ln -s $(DOTFILES_DIR)/config/vim/ideavimrc $$HOME/.ideavimrc
	vim  +PlugInstall +:qall

install-tmux-files:
	rm -rf $$HOME/.tmux.conf
	ln -s $(DOTFILES_DIR)/config/tmux/tmux.conf $$HOME/.tmux.conf

install-grv-files:
	rm -rf $$HOME/.config/grv
	mkdir -p $$HOME/.config/grv
	ln -s $(DOTFILES_DIR)/config/grv/grvrc $$HOME/.config/grv/grvrc

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
	brew install terraform   || $(WARNMSG)
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
	sudo npm install -g yo grunt-cli bower
	sudo npm install -g generator-angular
	sudo npm install -g json2yaml
	sudo npm install -g serverless

install-pip-list:
	sudo easy_install pip || $(WARNMSG)
	#sudo pip install glances 		# show cpu mem realtime report
	sudo pip install warchdog || $(WARNMSG)		#utility to watch filesystem for changes
	sudo pip install ansible --quiet || $(WARNMSG)
	easy_install --user pip || $(WARNMSG)
	pip install --user virtualenv || $(WARNMSG)
	cd /tmp/ && curl -O https://bootstrap.pypa.io/get-pip.py
	cd python3 get-pip.py --user
	pip3 install awscli --upgrade --user

download-docker-images:
	docker pull tomcat


change2zsh:
	chsh -s /usr/bin/zsh

moveScreenshotDir2Downloads:
	defaults write com.apple.screencapture location $$HOME/Downloads
	killall SystemUIServer

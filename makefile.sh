#!/usr/bin/env bash
# @author Laurent Krishnathas

set -e
set -u
set -x

function hello_script(){
    echo "hello" $1
}

function test(){
    echo "ZSH_CUSTOM=$ZSH_CUSTOM"
}

function push_docker_image_to_ecr(){

    echo "IMAGE_NAME is $IMAGE_NAME"
    echo "IMAGE_VERSION is $IMAGE_VERSION"

    GIT_COMMIT=$(git log -1 --format=%h)

	docker tag $IMAGE_NAME $ECR_REGISTRY_URI/$IMAGE_NAME
	docker tag $IMAGE_NAME $ECR_REGISTRY_URI/$IMAGE_NAME:$IMAGE_VERSION
	docker tag $IMAGE_NAME $ECR_REGISTRY_URI/$IMAGE_NAME:$IMAGE_VERSION-$GIT_COMMIT
	docker push  $ECR_REGISTRY_URI/$IMAGE_NAME
	docker push  $ECR_REGISTRY_URI/$IMAGE_NAME:$IMAGE_VERSION
	docker push  $ECR_REGISTRY_URI/$IMAGE_NAME:$IMAGE_VERSION-$GIT_COMMIT
}

function install_brew_list(){
	brew update
	brew install colordiff || ${WARNMSG}
	brew install fasd	|| ${WARNMSG} # command line navigation utilities
	brew install git || ${WARNMSG}
	brew install git-extras || ${WARNMSG}
	brew install git-flow || ${WARNMSG}
	brew install jq		|| ${WARNMSG} # format json
	brew install tmux  || ${WARNMSG}  # terminal multiplexer
	brew install tree || ${WARNMSG}
	brew install wget || ${WARNMSG}
	brew install zsh || ${WARNMSG}
	brew install zsh-completions || ${WARNMSG}
	brew install ack || ${WARNMSG}
	brew install fzf || ${WARNMSG}
	brew install python || ${WARNMSG}
	brew install watch || ${WARNMSG}
	brew install node@8 || ${WARNMSG}
	brew install yarn || ${WARNMSG}
	brew install reattach-to-user-namespace || ${WARNMSG}
	brew install the_silver_searcher   || ${WARNMSG}
	brew cask install spectacle || ${WARNMSG}
	brew cask install iterm2 || ${WARNMSG}
	brew install unrar || ${WARNMSG}
	brew install warrensbox/tap/tfswitch || true #choosing different terraform versions
	brew install subversion@1.8 || ${WARNMSG}
  brew install git-secret || ${WARNMSG}
  brew install helm || ${WARNMSG}
}

$*
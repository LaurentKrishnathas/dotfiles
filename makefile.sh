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
	brew install yarn || ${WARNMSG}
	brew install reattach-to-user-namespace || ${WARNMSG}
	brew install the_silver_searcher   || ${WARNMSG}
	brew install unrar || ${WARNMSG}
	brew install warrensbox/tap/tfswitch || true #choosing different terraform versions
	brew install subversion@1.8 || ${WARNMSG}
  brew install git-secret || ${WARNMSG}
  brew install helm || ${WARNMSG}
}


function ollama_migrate_models() {
  local source_dir="${HOME}/.ollama/models"
  local target_dir="/Users/Shared/ollama_models"

  # Create the target directory if it doesn't exist
  mkdir -p "${target_dir}"

  # Move the models to the shared directory
  mv "${source_dir}"/* "${target_dir}/"

  # Set the appropriate permissions for the shared directory
  chmod -R 755 "${target_dir}"
  chown -R :staff "${target_dir}"

  echo "Models have been moved to ${target_dir} and permissions set."
}

function ollama_symlink_models() {
  local shared_dir="/Users/Shared/ollama_models"
  local user_dir="${HOME}/.ollama/models"
  local backup_dir="${HOME}/.ollama/models_backup_$(date +%s)"

  # Rename the existing models directory if it exists
  if [ -d "${user_dir}" ]; then
    mv "${user_dir}" "${backup_dir}"
  fi

  # Create a symbolic link for the entire models directory
  ln -s "${shared_dir}" "${user_dir}"

  echo "Symbolic link created from ${shared_dir} to ${user_dir}. Existing models directory renamed to ${backup_dir}."
}



$*
#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function docker_init {
	file_array=()
	file_array+="app.Dockerfile"
	file_array+="Makefile"
	file_array+="makefile.sh"
	file_array+=".dockerignore"
	file_array+="README.md"

	for file in "${file_array[@]}"
	do
		if [ ! -f $file ]; then
			cp $DOTFILES_DIR/docker/init/$file ./${file}.rename_me
			echo "$file created"
		else
			echo "Ignored: $file aldready exists"
		fi		
	done
}

function docker_pull {
    docker pull alpine
    docker pull centos:7
    docker pull golang
    docker pull gradle
    docker pull guywithnose/sqlplus
    docker pull hashicorp/terraform
    docker pull httpd
    docker pull nginx
    docker pull node
    docker pull openjdk:8
    docker pull python
    docker pull tomcat
    docker pull tomcat
    docker pull traefik
    docker pull ubuntu
}
function docker_build { # build dockerfile by parsing to get name and version
    docker_cleanup
	echo "WARNING: use best practice with LABEL, ex: LABEL maintainer, LABEL description etc ..."
	# //TODO replace ENV VERSION with LABEL build.version to avoid messing up env, which can be used by other programes
	# //TODO add support for more meta data: date, builder, relative path
	dockerfile=$1
	shift
	args=$*

	if [ ! -f "$dockerfile" ]; then
		echo "ERROR: no docker file "
		echo "Usage: docker-build dockefilepath"
		return 1
	fi
	
	dockerfileDir=$(dirname $dockerfile)

	version=$(cat $dockerfile | grep "^LABEL image_version"|cut -d'"' -f2)
	name=$(cat $dockerfile | grep "^LABEL image_name"|cut -d'"' -f2)

	if [ "$version" = "" ];then
		echo "WARNING: user of ENV VERSION deprecated, use LABEL image_version in $dockerfile "
        version=$(cat $dockerfile | grep "^ENV VERSION " | cut -d' ' -f3)
	fi

	if [ "$name" = "" ];then
        name=$(cat $dockerfile | grep "^ENV NAME " | cut -d' ' -f3)
        echo "WARNING: user of ENV NAME deprecated, use LABEL image_name in $dockerfile "
	fi


	if [ "$version" = "" ];then
		echo "ERROR: can not build as there is no ENV VERSION in $dockerfile "
		return 1
	fi

	if [ "$name" = "" ];then
		echo "ERROR: can not build as there is no ENV NAME in $dockerfile "
		return 1
	fi

	# no idea what was this version_suffix 
	# if [ ! "$version_suffix" = "" ];then
	# 	version="$version-$version_suffix"	
	# fi

	echo "Options:"
	cat $dockerfile | grep "^ENV " | sort
	echo " "
	cat $dockerfile | grep "^ARG " | sort
	echo "..."

	echo "/> docker build -t "$name:$version" --rm=false -f $dockerfile $args $dockerfileDir ..."
	docker build -t "$name:$version" --rm=false -f $dockerfile $args $dockerfileDir 
	echo "/>  docker tag $name:$version $name\:latest ..."
	# warning: ':' is needed as somehow :l is disapearing
	docker tag $name:$version $name':'latest
	docker images $name
}

function docker_push { # build dockerfile by parsing to get name and version
	dockerfile=$1
	shift
	args=$*

	if [ ! -f "$dockerfile" ]; then
		echo "ERROR: no docker file "
		echo "Usage: docker-build dockefilepath"
		return 1
	fi
	
	dockerfileDir=$(dirname $dockerfile)

	version=$(cat $dockerfile | grep "^ENV VERSION " | cut -d' ' -f3)
	name=$(cat $dockerfile | grep "^ENV NAME " | cut -d' ' -f3)

	if [ "$version" = "" ];then
		echo "ERROR: can not build as there is no ENV VERSION in $dockerfile "
		return 1
	fi

	if [ "$name" = "" ];then
		echo "ERROR: can not build as there is no ENV NAME in $dockerfile "
		return 1
	fi

	if [ "$ECR_REGISTRY_URI" = "" ];then
		echo "ERROR: can not build as there is no ECR_REGISTRY_URI  "
		return 1
	fi

	# no idea what was this version_suffix 
	# if [ ! "$version_suffix" = "" ];then
		# version="$version-$version_suffix"	
	# fi

	echo "/> docker tag $name:$version $ECR_REGISTRY_URI/$name:$version ???"
	echo "/> docker push $ECR_REGISTRY_URI/$name:$version ???"
	echo "continue ? press any key."	
	read press_key
	docker tag $name:$version $ECR_REGISTRY_URI/$name:$version
	docker push $ECR_REGISTRY_URI/$name:$version
}

function docker_build_push {
	docker_build $*
	docker_push $*
}

function build_docker_images_dir {
    dir=$1

    for file in `ls $dir|grep Dockerfile`
    do
        echo "$file ..."
        docker_build $dir/$file
    done
}

function build_docker_images {
    docker_cleanup

    build_docker_images_dir  $DOTFILES_DIR/infra/docker/image/base
    build_docker_images_dir  $DOTFILES_DIR/infra/docker/image
}

function docker_login_aws {
	echo "login to ecr ..."
	loginStr=$(aws ecr get-login --region eu-west-1 --no-include-email)
	# echo $loginStr
	echo $loginStr| bash
}

function docker_tag_push {
	src_container=$1
	dest_container=$2

	if [ "$src_container" = "" ];then
		echo "ERROR: src_container missing "
		return 1
	fi

	if [ "$dest_container" = "" ];then
		echo "ERROR: dest_container missing "
		return 1
	fi

	if [ "$ECR_REGISTRY_URI" = "" ];then
		echo "ERROR: can not build as there is no ECR_REGISTRY_URI  "
		return 1
	fi

	echo "/> docker tag $src_container $ECR_REGISTRY_URI/$dest_container ???"
	echo "continue ? press any key."	
	read press_key
	docker tag $src_container $ECR_REGISTRY_URI/$dest_container

	echo "/> docker push $ECR_REGISTRY_URI/$dest_container ???"
	echo "continue ? press any key."	
	read press_key
	docker push $ECR_REGISTRY_URI/$dest_container
}

function docker_cleanup {		#... docker-cleanup
	docker rm $(docker ps -a -q) 
	docker rmi $(docker images -q -f dangling=true) 
	docker volume prune -f
}

function docker_cleanup_all {		#... docker-cleanup
	echo "WARNING: completely destroy all images"
	read press_any_key
	# docker kill $(docker ps -q)
	docker rm $(docker ps -a -q) 
	docker rmi $(docker images -q -f dangling=true) 
	docker rmi $(docker images -q)
	docker volume prune -f
	docker volume rm $(docker volume ls -q)
	rm -rf ~/Library/Containers/com.docker.docker/Data/*
}

function docker_exec {		#... docker exec -it $1 bash
	echo "docker exec -it $1 bash ..."
	docker exec -it $1 bash
}

function docker_report {		#... dockerreport
	echo "-------VERSION--------"
	docker version
	echo "-------INFO--------"
	docker info
	echo "-------IMAGES--------"
	docker images
	echo "-------PS--------"
	docker ps
}


function docker_project_init {
	for file in ~/code/src/github.com/dotfiles.git/infra/docker/image/reference-project/*
	do
            name=${file##*/}
			echo "copying file $file  to ${name}.TODO"
			cp -r $file ./${name}.TODO
	done
}
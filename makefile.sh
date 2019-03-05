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

$*
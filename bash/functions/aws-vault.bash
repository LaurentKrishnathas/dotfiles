#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

AWS_PATH=~/Library/Python/3.7/bin/aws
TERRAFORM_PATH=/usr/local/bin/terraform
MAKE_PATH=/usr/bin/make

function aws-vault-helper {
    AWS_VAULT=${AWS_VAULT:-""}
    CMD_=$1

    if [ -z "$AWS_DEFAULT_PROFILE" ]
    then
        echo "Warning AWS_DEFAULT_PROFILE is not set "
        return
    fi

    if [ -z "$AWS_VAULT" ]
    then
        shift
        aws-vault exec "${AWS_DEFAULT_PROFILE:-work}"  -- $CMD_ "$@"
    else
        shift
        $CMD_ "$@"
    fi
    set +x
}

function aws {
    aws-vault-helper $AWS_PATH $@
}

function terraform {
    aws-vault-helper $TERRAFORM_PATH $@
}

function make {
    aws-vault-helper $MAKE_PATH $@
}

#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019


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
}

function aws {
    aws-vault-helper ~/Python/3.7/bin/aws $@
}

function terraform {
    aws-vault-helper /usr/local/bin/terraform $@
}

function make {
    aws-vault-helper /usr/bin/make $@
}

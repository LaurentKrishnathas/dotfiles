#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function aws-vault-helper {
#    set -x
    AWS_VAULT=${AWS_VAULT:-""}
    CMD_=$1



    if [ -z "$AWS_VAULT" ]
    then
        if [ -z "$AWS_DEFAULT_PROFILE" ]
        then
            echo "Warning AWS_DEFAULT_PROFILE is not set "
            set +x
            return
        else
            shift
            aws-vault exec "${AWS_DEFAULT_PROFILE:-NOT_SET}"  -- $CMD_ "$@"
        fi
    else
        shift
        $CMD_ "$@"
    fi
#    set +x
}

function aws {
    aws-vault-helper aws $@
}

function terraform {
    aws-vault-helper terraform $@
}

function av-make {
    aws-vault-helper make $@
}

function make-av {
    aws-vault-helper make $@
}

function gradlew {
    aws-vault-helper ./gradlew $@
}

function av-gradle {
    aws-vault-helper ./gradlew $@
}

function kubectl {
    aws-vault-helper kubectl $@
}

function kubens {
    aws-vault-helper kubens $@
}

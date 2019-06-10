#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function ssm {		#... .restartWifi
    INSTANCE_NAME=$1
	aws ssm start-session --target $(aws ec2 describe-instances --region eu-west-1 --filters "Name=tag:Name,Values=$(INSTANCE_NAME)" --query "Reservations[*].Instances[*].InstanceId" --output=text)

}

function switchAWSProfile {
    unsetAWS
    aws-vault list
    PROFILE=$1
    echo "trying to swtich to $PROFILE ..."
    eval "$(aws-vault  exec $PROFILE  -- env|grep AWS|sed 's/^/export /' )"
    echo "checking identitty ..."
    aws sts get-caller-identity || echo "maybe sts permission missing ?"
    echo "switched to seesion ..."
}

function unsetAWS {
    echo "unsetting all AWS* env"
    unset AWS_VAULT
    unset AWS_DEFAULT_REGION
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_SECURITY_TOKEN
}

#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function ssm {		#... .restartWifi
    INSTANCE_NAME=$1
	aws ssm start-session --target $(aws ec2 describe-instances --region eu-west-1 --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query "Reservations[*].Instances[*].InstanceId" --output=text)

}

function ssm_name {		#... .restartWifi
    INSTANCE_NAME=$1
	aws ssm start-session --target $(aws ec2 describe-instances --region eu-west-1 --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query "Reservations[*].Instances[*].InstanceId" --output=text)
}

function ssm_id {		#... .restartWifi
    INSTANCE_NAME=$1
	aws ssm start-session --target $INSTANCE_NAME
}



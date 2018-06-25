#!/bin/sh
# @author Laurent Krishnathas

set -e
set -u
set -x

date
echo "`date` This is a sample script, run by cron!, please overide this script on runtime"
aws --version
#aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output=text
 
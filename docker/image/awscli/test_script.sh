#!/bin/sh
# @author Laurent Krishnathas

set -e
set -u
set -x

# code goes here.
date
echo "`date` This is a script, run by cron!"
id
whoami
aws --version
aws ec2 describe-instances --query 'Reservations[*].Instances[*]' --output=text
 
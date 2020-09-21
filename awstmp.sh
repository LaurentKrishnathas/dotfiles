#!/bin/bash
#
# Sample for getting temp session token from AWS STS
#
# aws --profile youriamuser sts get-session-token --duration 3600 \
# --serial-number arn:aws:iam::012345678901:mfa/user --token-code 012345
#
# Based on : https://github.com/EvidentSecurity/MFAonCLI/blob/master/aws-temp-token.sh
#

AWS_CLI=`which aws`

if [ $? -ne 0 ]; then
  echo "AWS CLI is not installed; exiting"
  exit 1
else
  echo "Using AWS CLI found at $AWS_CLI"
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0  <MFA_TOKEN_CODE>"
  echo "Where:"
  echo "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
  exit 2
fi

AWS_USER_PROFILE=tmp
AWS_2AUTH_PROFILE=2auth
ARN_OF_MFA=arn:aws:iam::101999902141:mfa/lk@dotmatics.com
MFA_TOKEN_CODE=$1
DURATION=129600

echo "AWS-CLI Profile: $AWS_CLI_PROFILE"
echo "MFA ARN: $ARN_OF_MFA"
echo "MFA Token Code: $MFA_TOKEN_CODE"
set -x

#read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
#$( aws --profile $AWS_USER_PROFILE sts get-session-token \
#  --duration $DURATION  \
#  --serial-number $ARN_OF_MFA \
#  --token-code $MFA_TOKEN_CODE \
#  --output text  | awk '{ print $2, $4, $5 }')


read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
$( aws --profile $AWS_USER_PROFILE sts get-session-token \
  --duration $DURATION  \
  --output text  | awk '{ print $2, $4, $5 }')
echo "AWS_ACCESS_KEY_ID: " $AWS_ACCESS_KEY_ID
echo "AWS_SECRET_ACCESS_KEY: " $AWS_SECRET_ACCESS_KEY
echo "AWS_SESSION_TOKEN: " $AWS_SESSION_TOKEN

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  exit 1
fi

`aws --profile $AWS_2AUTH_PROFILE configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"`
`aws --profile $AWS_2AUTH_PROFILE configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"`
`aws --profile $AWS_2AUTH_PROFILE configure set aws_session_token "$AWS_SESSION_TOKEN"`


aws --profile tmp-admin2  sts get-caller-identity | cat
aws --profile tmp-admin2 s3 ls
aws --profile tmp-admin2 ec2 describe-addresses --region eu-west-1



aws --profile tmp-admin3  sts get-caller-identity | cat
aws --profile tmp-admin3 s3 ls
aws --profile tmp-admin3 ec2 describe-addresses --region eu-west-1

#!/usr/bin/env bash
set -x
set -e
set -u

dir="$( cd "$(dirname "$0")" ; pwd -P )"

crontab -l
crontab crontab/crontab.bash
crontab -l

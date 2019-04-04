#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019


function clean_git_config {
    cat .git/config
    timestamp=$(date +%s)
    mv -f .git/config .git/config_$timestamp
    awk '!seen[$0]++' .git/config_$timestamp >.git/config
    cat .git/config
}
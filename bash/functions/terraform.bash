#!/usr/bin/env bash

#
# @author Laurent Krishnathas
# @year 2019


function terraform_project_init {
	for file in ~/code/src/codecommit/buildscripts.git/infra/terraform/live/reference-project/test/*
	do
            name=${file##*/}
			echo "copying file $file  to ${name}.TODO"
			cp -r $file ./${name}.TODO
	done
}
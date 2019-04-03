#!/usr/bin/env bash

function terraform_project_init {
	for file in ~/code/src/codecommit/devops-cd.git/terraform/live/sample/dev/*
	do
            name=${file##*/}
			echo "copying file $file  to ${name}.TODO"
			cp -r $file ./${name}.TODO
	done
}
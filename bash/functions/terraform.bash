#!/usr/bin/env bash

function terraform_project_init {
	for file in $DOTFILES_DIR/infra/terraform/live/sample/test/*
	do
            name=${file##*/}
			echo "copying file $file  to ${name}.TODO"
			cp -r $file ./${name}.TODO
	done
}
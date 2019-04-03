#!/usr/bin/env bash

function make_init {
	file_array=()
	file_array+="Makefile"
	file_array+="makefile.sh"

	for file in "${file_array[@]}"
	do
		if [ ! -f $file ]; then
			cp $DOTFILES_DIR/infra/docker/init/$file ./${file}.rename_me
			echo "$file created"
		else
			echo "Ignored: $file aldready exists"
		fi
	done
}
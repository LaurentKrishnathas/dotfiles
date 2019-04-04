#!/usr/bin/env bash
#
# @author Laurent Krishnathas
# @year 2019

function tmuxinator_init {
    # This function initialize tmuxinator sample file
	file_array=()
	file_array+="test.yml"

	for file in "${file_array[@]}"
	do
		if [ ! -f $file ]; then
		    mkdir .tmuxinator
			cp $DOTFILES_DIR/tmuxinator/init/$file .tmuxinator/${file}.rename_me
			echo "$file created"
		else
			echo "Ignored: $file aldready exists"
		fi
	done
}
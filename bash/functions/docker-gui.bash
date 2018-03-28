function docker_gui {
	image=$1
	args=""
	if [ "$image" = "" ];then
		echo "Usage /> docker_gui image_name:"
		echo "Example:"
		echo "	gns3/xeyes"
		echo "	jess/atom"
		echo "	jess/chrome"
		echo "	jess/firefox"
		echo "	jess/spotify"
		echo "	jess/tor-browser"
		echo "	jarfil/gimp-git"
		echo "	chrisdaish/libreoffice"
		echo "	eclipse/che"
		echo "	leesah/eclipse"
		echo "	chrisdaish/vlc"
		echo "	haron/vim"
		echo "	yantis/filezilla"
		echo "	notepad"
	elif [ "$image" = "notepad" ];then
		name="notepad"
		image="wine"
		args="wine \"C:\windows\system32\notepad.exe\""
	elif [ "$image" = "eclipse/che"];then
		docker run  -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/che:/data eclipse/che start
	else
		name=$(echo $image | tr '/' '_' | tr ':' '_')
	fi
	
	if [ "$image" = "" ];then
		echo "..."
	else
		# jess/chrome fail without --security-opt seccomp:unconfined  option
		docker container stop $name
		docker container rm $name
		cmd="docker container run \
			--rm \
			--name $name \
			-d \
			--security-opt seccomp:unconfined \
			-e DISPLAY=$IP:0 \
			-v $(pwd):/code \
			-v $HOME/Downloads:/root/Downloads \
			$image $args"
		echo "/> $cmd" | tr -s " " | tr "\t" " "
		eval $cmd
		docker ps	
	fi
}
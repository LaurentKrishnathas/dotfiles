- Creating windows vagrant box:
	create a vm in virtual box and use iso file to install windows and follow the article
		http://huestones.co.uk/node/305
	
		# windows10 is the name given to the vm in virtualbox
		# Vagrantfile contains default setting for the box
		vagrant package --base windows10 --output ./lk-windows-10.box --vagrantfile ./Vagrantfile
		vagrant box add ./lk-windows-10.box --name lk-windows-10


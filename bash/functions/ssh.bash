# shortcut for ssh
function ssh-add-loadall {		#... shortcut for ssh  test19"|rbuild02|
	ssh-add $HOME/.ssh/id_rsa
	ssh-add $HOME/.ssh/bitbucket/bitbucket_id_rsa
}

#function _ssh {		#... shortcut for ssh  test19"|rbuild02|
#	echo "nope, dddd use config file for password less"
#}

function ssh_ec2 {		#... shortcut for ssh  test19"|rbuild02|
	echo "ssh   -i  ~/.ssh/celgene.pem ec2-user@$1 ..."
	 ssh   -i  ~/.ssh/celgene.pem ec2-user@$1
}
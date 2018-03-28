

build_docker_image:
	source $$DOTFILES_DIR/src/main/bash/functions/docker.bash && docker_build ansible.Dockerfile

ping:
	ansible -i inventory qa  -m win_ping

docker_playbook_qa:
	docker run -it -v $$(pwd):/data ansible:1.0  	ansible-playbook playbook-install-browser.yml  -i inventory

playbook_qa:
	ansible-playbook   playbook-install-browser.yml  -i inventory
# vagrant setup
	vagrant destroy -f
	vagrant up
	ssh-keygen -R "[127.0.0.1]:2222"

#install all modules
	recommended to use git submodule checkout instead of ansible-galaxy
	X ansible-galaxy install -r requirements.yml -p ./roles 

#run config
	ansible svnserve -i test -m ping
	ansible-playbook --list-hosts ci-server.yml -i test
	ansible-playbook --list-tasks ci-server.yml -i test
	ansible-playbook  ci-slave.yml -i test -vv --limit ci-slave,svnserve
	
---------
Requirement on ubuntu:
	   sudo apt-get update
	   sudo apt-get install python2.7
	   sudo ln -s /usr/bin/python2.7 /usr/bin/python
	   
PB1: on centos everything works ok
	on ubuntu, need to change jenkins admin password manually to admin, 
	then some jenkins plugin fail first time

PB2: --limit=hostName, --limit match only hostnames so  
	host file should use "ci-slave.uk-bis-vcs-001 ansible_ssh_host=uk-bis-vcs-001" pattern
	putting real host name first will end up running all playbook and tasks of that host

Running commands:
	ansible all -s -m shell -a 'apt-get install nginx'

with apt module:
	ansible all -s -m apt -a 'pkg=nginx state=installed update_cache=true'

Installing roles:
	https://www.theodo.fr/blog/2015/10/best-practices-to-build-great-ansible-playbooks/
		recommended to use git submodule checkout instead of ansible-galaxy
	ansible-galaxy install geerlingguy.java -p ./roles
	ansible-galaxy install geerlingguy.git -p ./roles
	ansible-galaxy install geerlingguy.svn -p ./roles
	ansible-galaxy install geerlingguy.jenkins -p ./roles


Using play book:
	ansible-playbook -s nginx.yml
	
	nginx.yml:
		---
		- hosts: local
		  tasks:
		   - name: Install Nginx
		     apt: pkg=nginx state=installed update_cache=true
		     notify:
			    - Start Nginx 

		handlers:
		   - name: Start Nginx
		     service: name=nginx state=started

Play book with multiple tasks:
	multiplexx.yml
		---
		- hosts: local
		  vars:
		   - docroot: /var/www/serversforhackers.com/public
		  tasks:
		   - name: Add Nginx Repository
		     apt_repository: repo='ppa:nginx/stable' state=present
		     register: ppastable

		   - name: Install Nginx
		     apt: pkg=nginx state=installed update_cache=true
		     when: ppastable|success
		     register: nginxinstalled
		     notify:
		      - Start Nginx

		   - name: Create Web Root
		     when: nginxinstalled|success
		     file: dest={{ '{{' }} docroot {{ '}}' }} mode=775 state=directory owner=www-data group=www-data
		     notify:
		      - Reload Nginx

		  handlers:
		   - name: Start Nginx
		     service: name=nginx state=started

		    - name: Reload Nginx
		      service: name=nginx state=reloaded


Organizing with Role: each folder contains main.yml file
	rolename
	 - files
	 - handlers
	 - meta
	 - templates
	 - tasks
	 - vars



This docker-compose file is working ok.

PB1: slave asked to configure master url 
PB2: docker-compose scale master=2 : messed things, dkc rm -f fixed


PS: master and slave need to access project folder when a local git repo is used
	file:///Projects/buildscripts.git

the volumns keep state, if deleted then need start configuring jenkins
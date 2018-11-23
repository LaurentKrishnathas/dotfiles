# @author Laurent Krishnathas
# @version 2017/10/19

# Installing make on Coreos tricks
# docker run -ti --rm -v /opt/bin:/out ubuntu:14.04 /bin/bash -c "apt-get update && apt-get -y install make && cp /usr/bin/make /out/make"

test:
	echo hello

sync:
	rsync -rvqzhq --progress ./ vagrant@192.168.64.153:/vagrant

sqlserver:
	#aldready running	
	#docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=lk2017dDasesetaes443' -p 1433:1433 -d  microsoft/mssql-server-linux

ah.postgres:
	#user postgres
	docker run --restart=always --name ah.postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:10.2




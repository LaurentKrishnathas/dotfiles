compose-down:
	docker-compose down
	
compose-down-remove-orphans:
	docker-compose down --remove-orphans -v
	
compose-up:
	time docker-compose up -d
	
compose-run:
	time docker-compose run -d elasticsearch
	time docker-compose run -d logstash
	time docker-compose run -d kibana

compose-logs:
	docker-compose logs -f

samplefile:
	cat sample.txt | nc -w 1 -v localhost 5000
	
sampleContainer:
	docker run \
	 --log-driver=syslog \
	 --log-opt syslog-address=tcp://localhost:5000 \
	 --log-opt syslog-facility=daemon \
	 tomcat:8
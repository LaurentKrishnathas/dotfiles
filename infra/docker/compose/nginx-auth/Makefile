up:
	docker-compose up -d

clean:
	docker-compose stop
	docker-compose rm -f

restart:
	docker-compose stop nginx
	docker-compose rm -f nginx
	docker-compose stop springboot
	docker-compose rm -f springboot
	docker-compose up -d 


test:

	curl -i http://localhost/tomcat7 |grep HTTP
	curl -i http://localhost/tomcat8 |grep HTTP
	curl -i http://localhost/support |grep HTTP
	curl -i http://localhost/auth |grep HTTP
	curl -i http://localhost/auth2 |grep HTTP

check:
	docker-compose ps
ps:
	docker-compose ps
logs:
	docker-compose logs

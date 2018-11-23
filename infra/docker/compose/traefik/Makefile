all: clean up

clean:
		docker-compose stop
		docker-compose rm -f

up:
		docker-compose up -d

logs:
		docker-compose ps
		docker-compose logs -f
ps:
		docker-compose ps
